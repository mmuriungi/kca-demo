page 54416 "PC Employee Subcategories"
{
    Caption = 'PC Employee  Subcategories';
    PageType = ListPart;
    SourceTable = "PC WorkPlan Sub Categories";

    layout
    {
        area(content)
        {
            repeater(control)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }
                field("Quarter Target"; Rec."Quarter Target")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter Target field.';
                }
                field("Quarter Achievement"; Rec."Quarter Achievement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter Achievement field.';
                }
                field("Quarter Cummulative"; Rec."Quarter Cummulative")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter Cummulative field.';
                }

                field("Quarter Remarks"; Rec."Quarter Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quarter Remarks field.';
                }
            }
        }
    }
}
