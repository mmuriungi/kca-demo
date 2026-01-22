page 52050 "Survey List"
{
    ApplicationArea = All;
    Caption = 'Survey List';
    PageType = List;
    SourceTable = "Survey Header";
    UsageCategory = Lists;
    CardPageId = "Survey Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Survey Code"; Rec."Survey Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {

        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}
