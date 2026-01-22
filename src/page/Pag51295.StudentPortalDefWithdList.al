page 50075 "Student Portal Def/Withd List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Deferment/Withdrawal";
    Caption = 'Student Deferment/Withdrawal Requests';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Requests)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the request number.';
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is a deferment or withdrawal request.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the request was submitted.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for the request.';
                }
                field("Semester"; Rec."Semester")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester for the request.';
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the request.';
                    StyleExpr = StatusStyleExpr;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StudentDefermentWithdrawalCard: Page "Student Deferment/Withdrawal";
                begin
                    StudentDefermentWithdrawalCard.SetRecord(Rec);
                    StudentDefermentWithdrawalCard.Run();
                end;
            }

            action(CancelRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    WebPortals: Codeunit webportals;
                    Result: Text;
                begin
                    if Confirm('Are you sure you want to cancel this request?') then begin
                        Result := WebPortals.CancelDefermentWithdrawalRequest(Rec."No.", Rec."Student No.");
                        Message(Result);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    local procedure SetStatusStyle()
    begin
        case Rec.Status of
            Rec.Status::Open:
                StatusStyleExpr := 'Standard';
            Rec.Status::"Pending":
                StatusStyleExpr := 'Attention';
            Rec.Status::Approved:
                StatusStyleExpr := 'Favorable';
            Rec.Status::Rejected:
                StatusStyleExpr := 'Unfavorable';
            else
                StatusStyleExpr := 'Standard';
        end;
    end;

    var
        StatusStyleExpr: Text;
}
