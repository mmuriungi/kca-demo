page 51386 "FLT-Fuel and Maint. List"
{
    PageType = List;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = ORDER(Ascending)
                      WHERE(Status = FILTER(Approved));
    Caption = 'FLT-Fuel and Maint. List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                }
                field("Vendor(Dealer)"; Rec."Vendor(Dealer)")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
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
                field("Date Taken for Fueling"; Rec."Date Taken for Fueling")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    variant: Variant;
                    Approv: Codeunit "Approval Workflows V1";
                begin
                    variant := Rec;
                    if Approv.CheckApprovalsWorkflowEnabled(variant) then begin
                        Approv.OnSendDocForApproval(variant);
                    end;

                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    variant: Variant;
                    Approv: Codeunit "Approval Workflows V1";
                begin
                    variant := Rec;
                    if Approv.CheckApprovalsWorkflowEnabled(variant) then begin
                        Approv.OnCancelDocApprovalRequest(variant);
                    end;

                end;
            }

        }
    }
}

