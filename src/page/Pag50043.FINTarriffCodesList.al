page 50043 "FIN-Tarriff Codes List"
{
    PageType = List;
    SourceTable = "FIN-Tariff Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Subtraction Applies to"; Rec."Subtraction Applies to")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subtraction Applies to field.', Comment = '%';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

