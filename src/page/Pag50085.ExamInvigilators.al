page 50085 "Exam Invigilators"
{
    ApplicationArea = All;
    Caption = 'Exam Invigilators';
    PageType = List;
    SourceTable = "Exam Invigilators";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(Unit; Rec.Unit)
                {
                    ToolTip = 'Specifies the value of the Unit field.', Comment = '%';
                }
                field(Hall; Rec.Hall)
                {
                    ToolTip = 'Specifies the value of the Hall field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
            }
        }
    }
}
