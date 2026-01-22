page 50064 "HR Effected Asset Transfer"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = WHERE(Status = CONST(Approved),
                            Transfered = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Raised by"; Rec."Raised by")
                {
                    Editable = false;
                }
                field("Current Holder"; Rec."Current Holder")
                {
                }
                field("Current Holder Name"; Rec."Current Holder")
                {
                    Editable = false;
                }
                field("Asset to Transfer"; Rec."Asset to Transfer")
                {
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                }
                field("New Holder"; Rec."New Holder")
                {
                }
                field("New Holder Name"; Rec."New Holder")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Transfered; Rec.Transfered)
                {
                    Editable = false;
                }
                field("Date Transfered"; Rec."Date Transfered")
                {
                    Editable = false;
                }
                field("Transfered By"; Rec."Transfered By")
                {
                    Editable = false;
                }
                field("Time Transferred"; Rec."Time Transferred")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
                begin

                    DocumentType := DocumentType::"Asset Transfer";
                    ApprovalEntries.SetRecordFilters(DATABASE::"HR Asset Transfer Header", DocumentType, Rec."No.");
                    ApprovalEntries.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Updatecontrol;
    end;

    trigger OnAfterGetRecord()
    begin
        Updatecontrol;
    end;

    trigger OnInit()
    begin
        Edit := TRUE;
        Line := TRUE;
    end;

    var
        RecHeader: Record "HR Asset Transfer Header";
        ApprovalEntries: Page 658;
        Edit: Boolean;
        Line: Boolean;

    procedure Updatecontrol()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
        Edit:=TRUE;
        Line:=TRUE;
        END ELSE IF Status=Status::"Pending Approval" THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END ELSE IF Status=Status::Approved THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END
         */

    end;
}

