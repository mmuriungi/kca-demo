report 52178530 "Evaluation Appointment"
{
    Caption = 'Evaluation Appointment';
    DefaultLayout = RDLC;
    RDLCLayout = './Procurement/Reports/SSR/Evaluation Appointment.rdl';
    dataset
    {
        dataitem(ProcCommitteeMembers; "Proc-Committee Members")
        {
            RequestFilterFields = "Ref No", "Member No";
            DataItemTableView = where(Committee = filter(Evaluation));
            column(Committee; Committee)
            {
            }
            column(MemberType; "Member Type")
            {
            }
            column(RefNo; "Ref No")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(Name; Name)
            {
            }
            column(Email; Email)
            {
            }
            column(PhoneNo; "Phone No")
            {
            }
            column(Role; Role)
            {
            }
            column(Compinfopic; Compinfo.Picture)
            {

            }
            column(Compinfoname; Compinfo.Name)
            {

            }
            column(Compinfoaddress; Compinfo.Address)
            {

            }

            column(Compinfophone; Compinfo."Phone No.")
            {

            }
            column(Compinfoemail; Compinfo."E-Mail")
            {

            }
            column(Compinfowebpage; Compinfo."Home Page")
            {

            }
            dataitem("Proc-Committee Appointment H"; "Proc-Committee Appointment H")
            {
                DataItemLink = "Ref No" = field("Ref No");
                column(RefNo_ProcCommitteeAppointmentH; "Ref No")
                {
                }
                column(Date_ProcCommitteeAppointmentH; "Date")
                {
                }
                column(Description_ProcCommitteeAppointmentH; Description)
                {
                }
                column(To_ProcCommitteeAppointmentH; "To")
                {
                }
                column(TenderQuoteNo_ProcCommitteeAppointmentH; "Tender/Quote No")
                {
                }
                column(ProcurementMethod_ProcCommitteeAppointmentH; "Procurement Method")
                {
                }
                column(Tenderdesc; Tenderdesc)
                {

                }
                column(Openingdate; Openingdate)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    Purchasequote.Reset();
                    Purchasequote.SetRange("No.", "Tender/Quote No");
                    if Purchasequote.Find('-') then
                        Tenderdesc := Purchasequote.Description;
                    Openingdate := Purchasequote."Expected Opening Date";
                end;

            }

            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Ref No");

                column(ApproverID_ApprovalEntry; "Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Sender ID")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User Id" = field("Approver Id");
                    column(ApprovalTitle_UserSetup; "Approval Title")
                    {
                    }
                    column(UserSignature_UserSetup; "User Signature")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        "User Setup".CalcFields("User Signature");
                    end;
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {

            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        Compinfo.get();
        Compinfo.CalcFields(Picture);
    end;


    var
        MemberNo: Code[50];
        Compinfo: Record "Company Information";
        Tenderdesc: Text[2048];
        Purchasequote: Record "PROC-Purchase Quote Header";
        Openingdate: DateTime;
        Commitm: Record "Proc-Committee Members";
        Appointhe: Record "Proc-Committee Appointment H";

}
