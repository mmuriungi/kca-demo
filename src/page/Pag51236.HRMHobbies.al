page 51236 "HRM-Hobbies"
{
    Caption = 'HRM-Hobbies';
    PageType = ListPart;
    SourceTable = "HRM-Hobbies";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("PF No"; Rec."PF No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

            }
        }
    }
}
