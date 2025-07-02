page 50893 "ACA-Lecturer Units Details"
{
    PageType = List;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours Contracted"; Rec."No. Of Hours Contracted")
                {
                    ApplicationArea = All;
                }
                field("Available From"; Rec."Available From")
                {
                    ApplicationArea = All;
                }
                field("Available To"; Rec."Available To")
                {
                    ApplicationArea = All;
                }
                field("Time Table Hours"; Rec."Time Table Hours")
                {
                    ApplicationArea = All;
                }
                field("Unit Students Count"; Rec."Unit Students Count")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Allocation"; Rec."Student Allocation")
                {
                    ApplicationArea = All;
                }
                field("Required Equipment"; Rec."Required Equipment")
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Split Into Streams")
            {
                ApplicationArea = All;
                Caption = 'Split Into Streams';
                Image = Split;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    StreamSplittingMgt: Codeunit "Stream Splitting Mgt";
                begin
                    if Confirm('Do you want to split this unit into multiple streams based on student allocation?') then
                        StreamSplittingMgt.SplitLecturerUnitIntoStreams(Rec);
                end;
            }

            action("Preview Stream Split")
            {
                ApplicationArea = All;
                Caption = 'Preview Stream Split';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    StreamSplittingMgt: Codeunit "Stream Splitting Mgt";
                begin
                    StreamSplittingMgt.PreviewStreamSplit(Rec);
                end;
            }

            action("Batch Stream Splitting")
            {
                ApplicationArea = All;
                Caption = 'Batch Stream Splitting';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Batch Stream Splitting";
            }
        }
    }
    trigger OnOpenPage()
    var
        Allocations: Record "ACA-Lecturers Units";
    begin
        Allocations.Reset();
        Allocations.SetRange(Semester, 'SEM2 24/25');
        Allocations.SetRange("Student Allocation", 0);
        Allocations.SetAutoCalcFields("Unit Students Count");
        Allocations.SetFilter("Unit Students Count", '>%1', 0);
        if Allocations.FindSet() then begin
            Allocations.ModifyAll("Student Allocation", Allocations."Unit Students Count");
        end;
    end;
}

