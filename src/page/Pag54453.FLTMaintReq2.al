page 54453 "FLT-Maint. Req2."
{
    PageType = Card;
    SourceTable = "FLT Maintenance Request.";

    //SourceTableView = WHERE(Status = CONST(Open));

    layout
    {
        area(content)

        {

            group(General)
            {


                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Requesting officer"; rec."Requesting officer")
                {
                    ApplicationArea = All;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("requester Contact number"; rec."requester Contact number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Designation';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                }

                field("Maintanance Type"; rec."Maintanance Type")
                {
                    ApplicationArea = all;
                }
                field("Price/Litre"; rec."Price/Litre")
                {
                    ApplicationArea = All;
                }
                field("Quantity of Fuel(Litres)"; Rec."Quantity of Fuel(Litres)")
                {
                    ApplicationArea = All;
                }
                field("Total Price of Fuel"; Rec."Total Price of Fuel")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                }
            }
            group("Service Request")
            {
                field("Date of Service"; rec."Date of Service")
                {
                    ApplicationArea = All;
                }
                field("mileage at request of services"; rec."mileage at request of services")
                {
                    ApplicationArea = All;
                }
                field("mileage due at "; rec."mileage at service")
                {
                    caption = 'mileage due at Service';
                    ApplicationArea = All;

                }



            }
            group("Repair Request")
            {

                field("Date of Repair Request"; rec."Date of Repair Request")
                {
                    ApplicationArea = all;

                }
                field("Nature of repair"; rec."Nature of repair")
                {
                    ApplicationArea = all;

                }
                field("Mileage on Repair"; rec."Mileage on Repair")
                {
                    caption = 'mileage due at Repair';
                    ApplicationArea = all;
                }
            }
            group("Transport Officer ")
            {

                field("Action Taken"; rec."Action Taken")
                {
                    ApplicationArea = all;

                }
                field("Date Of Service/Repair "; rec."Date Of Service/Repair ")
                {
                    ApplicationArea = all;

                }
                field(Feedback; rec.Feedback)
                {
                    ApplicationArea = all;
                }
                field("Mileage at Service/Repair"; rec.remarks)
                {
                    caption = 'Mileage at Service/Repair';
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    Caption = 'Amount';

                    ApplicationArea = all;
                }
                field("Next Service Due Mileage"; Rec."Next Service Due Mileage")
                {
                    Caption = 'Next Service Due Mileage';

                    ApplicationArea = all;
                }

            }

        }

    }
    actions
    {
        area(processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Caption = 'Submit the  request ';
                Visible = (rec.Status = rec.Status::Open);

                trigger OnAction()
                begin
                    rec.status := rec.status::Submitted;
                    CurrPage.Update();
                end;
            }
            action(approve)
            {
                ApplicationArea = All;
                Caption = 'approve the Request';
                Visible = (rec.Status = rec.Status::Submitted);
                trigger OnAction()
                begin
                    rec.status := rec.status::Approved;
                    CurrPage.Update();
                end;
            }
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close the Request';
                Visible = (rec.Status = rec.Status::Approved);
                trigger OnAction()
                begin
                    rec.status := rec.status::Closed;

                    CurrPage.Update();
                end;
            }
        }
    }

}
