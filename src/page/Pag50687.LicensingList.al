page 50687 "Licensing List"
{
    Caption = 'Licensing List';
    PageType = List;
    SourceTable = "Licensing Bodies";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Application No"; Rec."Job Application No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Application No field.', Comment = '%';
                }
                field("License Number "; Rec."License Number ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License Number field.', Comment = '%';
                }

                field("licensing Body"; Rec."licensing Body")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the licensing Body field.', Comment = '%';
                }

                field("license period(from)"; Rec."license period(from)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the license period(from) field.', Comment = '%';
                }
                field("license period (To)"; Rec."license period (To)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the license period (To) field.', Comment = '%';
                }
            }
        }
    }
}
