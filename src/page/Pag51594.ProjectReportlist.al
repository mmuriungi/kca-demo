page 51594 "Project Report list"
{
    Caption = 'Project Report list';
    PageType = ListPart;
    SourceTable = "Project Report";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Report Code"; Rec."Report Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report Code field.', Comment = '%';
                }
                field("Reporting Date "; Rec."Reporting Date ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reporting Date field.', Comment = '%';
                }
                field("Reporting  month"; Rec."Reporting  month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reporting  month field.', Comment = '%';
                }
                field("Report description"; Rec."Report description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Report description field.', Comment = '%';
                }
            }
        }
    }
}
