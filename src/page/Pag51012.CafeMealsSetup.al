page 51012 "Cafe Meals Setup"
{
    Caption = 'Cafe Meals Setup';
    PageType = List;
    SourceTable = "CAT-Meals Setup";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Discription; Rec.Discription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discription field.';
                }
                field("Advance Sales"; Rec."Advance Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Sales field.';
                }
                field("Cash Sales"; Rec."Cash Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cash Sales field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Exclude in Summary"; Rec."Exclude in Summary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exclude in Summary field.';
                }
                field("Food Value"; Rec."Food Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Food Value field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Recipe Cost"; Rec."Recipe Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recipe Cost field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Total Credits"; Rec."Total Credits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Credits field.';
                }
                field("Total Debits"; Rec."Total Debits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Debits field.';
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Quantity field.';
                }
                field("Total Sales"; Rec."Total Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Sales field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
            }
        }
    }
}
