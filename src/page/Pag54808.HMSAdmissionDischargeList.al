page 54808 "HMS Admission Discharge List"
{
    PageType = List;
    SourceTable = "HMS-Admission Discharge Header";

    layout
    {
        area(content)
        {
            repeater(" ")
            {
                Editable = false;
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = All;
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Discharge Time"; Rec."Discharge Time")
                {
                    Caption = 'Time';
                    ApplicationArea = All;
                }
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    ApplicationArea = All;
                }
                field("Time Of Admission"; Rec."Time Of Admission")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;
                }
                field("Nurse ID"; Rec."Nurse ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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

