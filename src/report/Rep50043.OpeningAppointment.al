report 50043 "Opening Appointment"
{
    Caption = 'Opening Appointment';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Opening Appointment.rdl';
    dataset
    {

        dataitem(ProcCommitteeMembers; "Proc-Committee Members")
        {

            RequestFilterFields = "Member No";
            DataItemTableView = where(Committee = filter(Opening));
            column(Committee; Committee)
            {
            }
            column(MemberType; "Member Type")
            {
            }
            column(RefNo; "Ref No")
            {
            }
            column(MemberNo; GetFilter("Member No"))
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
            column(RefNo_ProcCommitteeAppointmentH; AppointmentH."Ref No")
            {
            }
            column(Date_ProcCommitteeAppointmentH; AppointmentH."Date")
            {
            }
            column(Description_ProcCommitteeAppointmentH; AppointmentH.Description)
            {
            }
            column(To_ProcCommitteeAppointmentH; AppointmentH."To")
            {
            }
            column(TenderQuoteNo_ProcCommitteeAppointmentH; AppointmentH."Tender/Quote No")
            {
            }
            column(ProcurementMethod_ProcCommitteeAppointmentH; AppointmentH."Procurement Method")
            {
            }
            column(Tenderdesc; Tenderdesc)
            {

            }
            column(Openingdate; Openingdate)
            {

            }
            dataitem("Approval Entry"; "Approval Entry")
            {

                DataItemLink = "Document No." = field("Ref No");
                RequestFilterHeading = '';
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
            trigger OnPreDataItem()
            begin

                ProcCommitteeMembers.SetRange("Member No", MemberNo);
            end;

            trigger OnAfterGetRecord()
            begin
                AppointmentH.Reset();
                AppointmentH.SetRange("Ref No", ProcCommitteeMembers."Ref No");
                if AppointmentH.Find('-') then begin
                    Purchasequote.Reset();
                    Purchasequote.SetRange("No.", AppointmentH."Tender/Quote No");
                    if Purchasequote.Find('-') then
                        Tenderdesc := Purchasequote.Description;
                    Openingdate := Purchasequote."Expected Opening Date";
                end;
            end;
        }






    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Member)
                {
                    field(MemberNo; MemberNo)
                    {
                        Caption = 'Member No';
                        ApplicationArea = all;
                        TableRelation = "Proc-Committee Membership"."Staff No." where("Committee Type" = filter("Opening Commitee"));
                        trigger OnDrillDown()
                        begin
                            Committmemship.Reset();
                            Committmemship.SetRange("No.", ProcCommitteeMembers."Ref No");
                            Committmemship.SetRange("Committee Type", Committmemship."Committee Type"::"Opening Commitee");
                            if Committmemship.Find('-') then
                                page.Run(page::"Proc-Committee Membership");
                        end;
                    }
                }

            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin

    end;

    trigger OnInitReport()
    begin
        Compinfo.get();
        Compinfo.CalcFields(Picture);

    end;


    var
        MemberNo: Code[50];
        Compinfo: Record "Company Information";
        Tenderdesc: Text[500];
        Purchasequote: Record "PROC-Purchase Quote Header";
        Openingdate: DateTime;
        Commitm: Record "Proc-Committee Members";
        QuoteNo: Code[50];
        AppointmentH: Record "Proc-Committee Appointment H";
        Committmemship: Record "Proc-Committee Membership";
}
