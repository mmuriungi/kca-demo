page 54815 "HMS Admission List"
{
    PageType = List;
    SourceTable = "HMS-Admission Form Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Admission No."; Rec."Admission No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Link Type"; Rec."Link Type")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Caption = 'Time';
                    ApplicationArea = All;
                }
                field(Ward; Rec.Ward)
                {
                    ApplicationArea = All;
                }
                field(Bed; Rec.Bed)
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
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

