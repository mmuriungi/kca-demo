page 54418 "PC Work Plan Setup"
{
    ApplicationArea = All;
    Caption = 'PC Work Plan Setup';
    PageType = List;
    SourceTable = "PC WorkPlans Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("S/No."; Rec."S/No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the S/No. field.';
                }
                field("Performance Criteria"; Rec."Performance Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performance Criteria field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Weight (%)"; Rec."Weight (%)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight (%) field.';
                }
                field("Status Previous Year"; Rec."Status Previous Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Previous Year field.';
                }
                field("Target (FY 2021/22)"; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target (FY 2021/22) field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }
            }
        }
    }
}
