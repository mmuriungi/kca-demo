page 54415 "Employee Perf Line"
{
    Caption = 'Employee Perf Line';
    PageType = ListPart;
    SourceTable = "Employee Perf Targets Line";
    ApplicationArea = all;
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
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Status Previous Year"; Rec."Status Previous Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Previous Year field.';
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
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target (FY 2021/22) field.';
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
                field("Individual Target"; Rec."Your Target")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Your Target field.';
                }
                // field(PI; Rec.PI)
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the value of the PI field.';
                // }
            }
        }
    }
}
