page 54209 "Actual Maintenance Lines"
{
    PageType = ListPart;
    SourceTable = "Actual Maintenance Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fixed Asset No."; Rec."Fixed Asset No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Actual Service Date"; Rec."Actual Service Date")
                {
                    ApplicationArea = All;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE;
    end;
}

