report 50829 "Batch Stream Splitting"
{
    Caption = 'Batch Stream Splitting';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    
    dataset
    {
        dataitem("ACA-Lecturers Units"; "ACA-Lecturers Units")
        {
            RequestFilterFields = Programme, Stage, Semester, "Academic Year", "Campus Code";
            
            trigger OnPreDataItem()
            begin
                if not Confirm('This will split all filtered lecturer units with student allocations exceeding %1 students into streams. Continue?', 
                               false, MaxStudentsPerStream) then
                    CurrReport.Quit();
                    
                Window.Open('Processing Lecturer Units\' +
                           'Programme: #1##########\' +
                           'Stage: #2##########\' +
                           'Unit: #3##########\' +
                           'Progress: #4######/@5######');
                           
                TotalRecords := Count();
                ProcessedRecords := 0;
            end;
            
            trigger OnAfterGetRecord()
            var
                StreamSplittingMgt: Codeunit "Stream Splitting Mgt";
                StudentAllocation: Integer;
            begin
                ProcessedRecords += 1;
                
                Window.Update(1, Programme);
                Window.Update(2, Stage);
                Window.Update(3, Unit + ' - ' + Description);
                Window.Update(4, ProcessedRecords);
                Window.Update(5, TotalRecords);
                
                // Skip if already has a stream
                if Stream <> '' then begin
                    SkippedAlreadyStreamed += 1;
                    exit;
                end;
                
                CalcFields("Registered Students");
                StudentAllocation := "Student Allocation";
                
                if StudentAllocation = 0 then
                    StudentAllocation := "Registered Students";
                
                // Skip if student allocation is below threshold
                if StudentAllocation <= MaxStudentsPerStream then begin
                    SkippedBelowThreshold += 1;
                    exit;
                end;
                
                // Process the splitting
                if PreviewOnly then begin
                    StreamsNeeded := StreamSplittingMgt.CalculateStreamsNeeded(StudentAllocation);
                    PreviewLog += StrSubstNo('%1 - %2 - %3: %4 students -> %5 streams\', 
                                            Programme, Stage, Unit, StudentAllocation, StreamsNeeded);
                    UnitsToSplit += 1;
                end else begin
                    StreamSplittingMgt.SplitLecturerUnitIntoStreams("ACA-Lecturers Units");
                    ProcessedUnits += 1;
                end;
            end;
            
            trigger OnPostDataItem()
            begin
                Window.Close();
                
                if PreviewOnly then begin
                    Message('Preview Results:\' +
                           'Total Units: %1\' +
                           'Units to Split: %2\' +
                           'Already Streamed: %3\' +
                           'Below Threshold: %4\' +
                           '\Details:\' +
                           '%5',
                           TotalRecords, UnitsToSplit, SkippedAlreadyStreamed, 
                           SkippedBelowThreshold, PreviewLog);
                end else begin
                    Message('Processing Complete:\' +
                           'Total Units: %1\' +
                           'Units Split: %2\' +
                           'Already Streamed: %3\' +
                           'Below Threshold: %4',
                           TotalRecords, ProcessedUnits, SkippedAlreadyStreamed, 
                           SkippedBelowThreshold);
                end;
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    
                    field(MaxStudentsPerStream; MaxStudentsPerStream)
                    {
                        ApplicationArea = All;
                        Caption = 'Maximum Students per Stream';
                        ToolTip = 'Specify the maximum number of students allowed per stream';
                        
                        trigger OnValidate()
                        begin
                            if MaxStudentsPerStream <= 0 then
                                Error('Maximum students per stream must be greater than 0');
                        end;
                    }
                    
                    field(PreviewOnly; PreviewOnly)
                    {
                        ApplicationArea = All;
                        Caption = 'Preview Only';
                        ToolTip = 'Check this to preview the splitting without making changes';
                    }
                }
            }
        }
        
        trigger OnOpenPage()
        begin
            MaxStudentsPerStream := 100;
            PreviewOnly := true;
        end;
    }
    
    var
        Window: Dialog;
        MaxStudentsPerStream: Integer;
        PreviewOnly: Boolean;
        TotalRecords: Integer;
        ProcessedRecords: Integer;
        ProcessedUnits: Integer;
        UnitsToSplit: Integer;
        SkippedAlreadyStreamed: Integer;
        SkippedBelowThreshold: Integer;
        StreamsNeeded: Integer;
        PreviewLog: Text;
}