#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 68205 "ACA-Student Hostel Booking"
{
    PageType = Document;
    SourceTable = "ACA-Students Hostel Rooms";

    layout
    {
        area(content)
        {
            group(Control1102760000)
            {
                field("Space No"; Rec."Space No")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        HostelLedger.Reset;
                        HostelLedger.SetRange(HostelLedger."Space No", Rec."Space No");
                        if HostelLedger.Find('-') then begin
                            Rec."Room No" := HostelLedger."Room No";
                            Rec."Hostel No" := HostelLedger."Hostel No";
                            Rec."Accomodation Fee" := HostelLedger."Room Cost";
                            Rec."Allocation Date" := Today;
                        end;
                    end;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Hostel No"; Rec."Hostel No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Accomodation Fee"; Rec."Accomodation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
            }
            action("Book Room")
            {
                ApplicationArea = Basic;
                Image = Save;

                trigger OnAction()
                begin
                    if Confirm('Do you really want to book the selected Room?') then begin
                        Sem.Reset;
                        Sem.SetRange(Sem."Current Semester", true);
                        if Sem.Find('-') then begin
                            StudHostel.Reset;
                            StudHostel.SetRange(StudHostel.Student, Rec.Student);
                            StudHostel.SetRange(StudHostel.Semester, Sem.Code);
                            StudHostel.SetRange(StudHostel.Billed, true);
                            if StudHostel.Find('-') then Error('Please note that you have already book the room in the current semester');
                            Rec.Semester := Sem.Code;
                            Rec.Billed := true;
                            Rec."Billed Date" := Today;
                            Message('Booking completed successfully');
                        end;
                    end;
                end;
            }
            separator(Action2)
            {
            }
            action("Print Booking Card")
            {
                ApplicationArea = Basic;
                Caption = 'Print Booking Card';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    StudHostel.Reset;
                    StudHostel.SetFilter(StudHostel.Student, Rec.Student);
                    //  StudHostel.SETFILTER(StudHostel.Semester,Semester);
                    if StudHostel.Find('-') then
                        Report.Run(39005954, true, true, Rec);
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
        StudHostel: Record "ACA-Students Hostel Rooms";
}

