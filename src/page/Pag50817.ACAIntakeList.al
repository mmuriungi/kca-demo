page 50817 "ACA-Intake List"
{
    PageType = Card;
    SourceTable = "ACA-Intake";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    Caption = 'School';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    ApplicationArea = All;
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = All;
                }
                field("Reporting End Date"; Rec."Reporting End Date")
                {
                    Caption = 'Semetser End Date';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                    TableRelation = "ACA-Academic Year".Code;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

