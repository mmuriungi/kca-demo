page 51187 "ACA-Stud Hostel Rooms Gen. X"
{
    PageType = ListPart;
    SourceTable = "ACA-Students Hostel Rooms";
    SourceTableView = WHERE(Billed = CONST(true));

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Space No"; Rec."Space No")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        HostelLedger.RESET;
                        HostelLedger.SETRANGE(HostelLedger."Space No", Rec."Space No");
                        IF HostelLedger.FIND('-') THEN BEGIN
                            Rec."Room No" := HostelLedger."Room No";
                            Rec."Hostel No" := HostelLedger."Hostel No";
                            Rec."Accomodation Fee" := HostelLedger."Room Cost";
                            Rec."Allocation Date" := TODAY;
                        END;
                    end;
                }
                field("Room No"; Rec."Room No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hostel No"; Rec."Hostel No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accomodation Fee"; Rec."Accomodation Fee")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Book Room")
            {
                ApplicationArea = All;
            }
            separator(Aggt)
            {
            }
            action("Print Agreement")
            {
                Caption = 'Print Agreement';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Creg.RESET;
                    Creg.SETFILTER(Creg."Student No.", Rec.Student);
                    Creg.SETFILTER(Creg.Semester, Rec.Semester);
                    IF Creg.FIND('-') THEN
                        REPORT.RUN(39005953, TRUE, TRUE, Creg);
                end;
            }
        }
    }

    var
        HostelLedger: Record "ACA-Hostel Ledger";
        StudentCharges: Record "ACA-Std Charges";
        PaidAmt: Decimal;
        ChargesRec: Record "ACA-Charge";
        Cust: Record Customer;
        GenSetup: Record "ACA-General Set-Up";
        Creg: Record "ACA-Course Registration";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;
}

