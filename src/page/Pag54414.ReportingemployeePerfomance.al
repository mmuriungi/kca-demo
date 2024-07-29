page 54414 "Reporting employee Perfomance"
{
    Caption = 'Reporting employee Perfomance ';
    PageType = ListPart;
    SourceTable = "Employee Perf Targets Line";

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
                field("Your Target"; Rec."Your Target")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Your Target field.';
                }
                field("Actual Achievement A"; Rec."Actual Achievement B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Achievement A field.';
                }
                field("Target for Quarter B"; Rec."Target for Quarter C")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target for Quarter B field.';
                }
                field("Variance B-C"; Rec."Variance B-C")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variance B-C field.';
                }
                field("Actual Achievement"; Rec."Actual Achievement E")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Achievement field.';
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target (FY 2021/22) field.';
                }
                field("Variance G"; Rec."Variance G")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Variance G field.';
                }

            }
        }
    }
}
