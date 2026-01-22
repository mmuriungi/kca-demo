page 50294 "Club Card"
{
    PageType = Card;
    SourceTable = Club;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Patron No."; Rec."Patron No.")
                {
                    ApplicationArea = All;
                }
                field("Founding Date"; Rec."Founding Date")
                {
                    ApplicationArea = All;
                }
                field("Member Count"; Rec."Member Count")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Club Members"; "Club Member")
            {
                ApplicationArea = All;
                subpagelink = "Club Code" = field("Code");
            }
            part(Activities; "Club/Society Activity ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "Club/Society Code" = field(Code);
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Visible = Rec."Approval Status" = Rec."Approval Status"::open;

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnSendDocForApproval(variant);
                end;
            }
            //cancelapproval
            action(CancelApproval)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval';
                Image = CancelApproval;
                Visible = Rec."Approval Status" = Rec."Approval Status"::"Pending";

                trigger OnAction()
                var
                    ApprovMgmt: Codeunit "Approval Workflows V1";
                    variant: Variant;
                begin
                    variant := Rec;
                    if ApprovMgmt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovMgmt.OnCancelDocApprovalRequest(variant);
                end;
            }
            action(Deactivate)
            {
                ApplicationArea = All;
                Caption = 'Deactivate Club';
                Image = Cancel;
                Visible = Rec.Status = Rec.Status::Active;

                trigger OnAction()
                var
                    ClubMgmt: Codeunit "Student Affairs Management";
                begin
                    ClubMgmt.DeactivateClub(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action(MembershipReport)
            {
                ApplicationArea = All;
                Caption = 'Membership Report';
                Image = Report;
                RunObject = Report "Club Membership Report";
            }
        }
    }
}