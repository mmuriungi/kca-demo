report 50658 "Meal Booking Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Meal Booking Form.rdl';

    dataset
    {
        dataitem("CAT-Meal Booking Header"; "CAT-Meal Booking Header")
        {
            PrintOnlyIfDetail = true;
            column(CompName; info.Name)
            {
            }
            column(Address1; info.Address)
            {
            }
            column(Address2; info."Address 2")
            {
            }
            column(City; info.City)
            {
            }
            column(Phone1; info."Phone No.")
            {
            }
            column(Phone2; info."Phone No. 2")
            {
            }
            column(Fax; info."Fax No.")
            {
            }
            column(Pic; info.Picture)
            {
            }
            column(postCode; info."Post Code")
            {
            }
            column(CompEmail; info."E-Mail")
            {
            }
            column(HomePage; info."Home Page")
            {
            }
            column(DocNo; "CAT-Meal Booking Header"."Booking Id")
            {
            }
            column(DeptCode; "CAT-Meal Booking Header".Department)
            {
            }
            column(DeptName; "CAT-Meal Booking Header"."Department Name")
            {
            }
            column(reqBy; "CAT-Meal Booking Header"."Requested By")
            {
            }
            column(ReqDate; "CAT-Meal Booking Header"."Request Date")
            {
            }
            column(BooKdate; "CAT-Meal Booking Header"."Booking Date")
            {
            }
            column(BookTime; "CAT-Meal Booking Header"."Booking Time")
            {
            }
            column(ReqTime; "CAT-Meal Booking Header"."Required Time")
            {
            }
            column(MeetingName; "CAT-Meal Booking Header"."Meeting Name")
            {
            }
            column(Venue; "CAT-Meal Booking Header".Venue)
            {
            }
            column(ContactPerson; "CAT-Meal Booking Header"."Contact Person")
            {
            }
            column(ContactNumber; "CAT-Meal Booking Header"."Contact Number")
            {
            }
            column(ContactMail; "CAT-Meal Booking Header"."Contact Mail")
            {
            }
            column(Pax; "CAT-Meal Booking Header".Pax)
            {
            }
            column(Status; "CAT-Meal Booking Header".Status)
            {
            }
            column(TotalCost; "CAT-Meal Booking Header"."Total Cost")
            {
            }
            column(ApprovedBy; ApprovalsEntries."Approver ID")
            {
            }
            column(ApprovalDate; ApprovalsEntries."Last Date-Time Modified")
            {
            }
            dataitem("CAT-Meal Booking Lines"; "CAT-Meal Booking Lines")
            {
                DataItemLink = "Booking Id" = FIELD("Booking Id");
                DataItemTableView = WHERE("Line No." = FILTER(<> 0));
                column(BkID; "CAT-Meal Booking Lines"."Booking Id")
                {
                }
                column(LineNo; "CAT-Meal Booking Lines"."Line No.")
                {
                }
                column(MealCode; "CAT-Meal Booking Lines"."Meal Code")
                {
                }
                column(MealName; "CAT-Meal Booking Lines"."Meal Name")
                {
                }
                column(Quantity; "CAT-Meal Booking Lines".Quantity)
                {
                }
                column(UnitPrice; "CAT-Meal Booking Lines"."Unit Price")
                {
                }
                column(Cost; "CAT-Meal Booking Lines".Cost)
                {
                }
                column(Price; "CAT-Meal Booking Lines".Price)
                {
                }
                column(Remarks; "CAT-Meal Booking Lines".Remarks)
                {
                }
            }
            // dataitem("Approval Entry"; "Approval Entry")
            // {
            //     DataItemLink = "Document No." = FIELD("Booking Id");
            //     DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.", "Approver ID")
            //                         ORDER(Ascending)
            //                         WHERE(Status = FILTER(Approved),
            //                               "Approved The Document" = FILTER(true));
            //     column(DateAndTime; "Approval Entry"."Last Date-Time Modified")
            //     {
            //     }
            //     column(ApproverId; "Approval Entry"."Approver ID")
            //     {
            //     }
            //     column(Title; userSetup6."Approval Title")
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         userSetup6.RESET;
            //         userSetup6.SETRANGE("User ID", "Approval Entry"."Approver ID");
            //         IF userSetup6.FIND('-') THEN BEGIN

            //         END;
            //     end;
            // }
            trigger OnAfterGetRecord()
            begin
                ApprovalsEntries.RESET;
                ApprovalsEntries.SETRANGE("Document No.", "CAT-Meal Booking Header"."Booking Id");
                ApprovalsEntries.SETRANGE("Table ID", DATABASE::"CAT-Meal Booking Header");
                ApprovalsEntries.SETRANGE("Sequence No.", 1);
                ApprovalsEntries.SETRANGE(Status, ApprovalsEntries.Status::Approved);
                IF ApprovalsEntries.FINDFIRST THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;

    var
        info: Record "Company Information";
        userSetup: Record "User Setup";
        userSetup1: Record "User Setup";
        userSetup2: Record "User Setup";
        userSetup3: Record "User Setup";
        userSetup4: Record "User Setup";
        userSetup5: Record "User Setup";
        userSetup6: Record "User Setup";
        ApprovalsEntries: Record "Approval Entry";
}

