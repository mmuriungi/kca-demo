page 50154 "FIN-Asset Transfer Card"
{
    Caption = 'Asset Transfer Card';
    PageType = Card;
    SourceTable = "FIN-Asset Transfer Header";

    layout
    {
        area(content)
        {
            group("New Details")
            {
                Caption = 'New Details"';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                    Editable = false;
                }
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset No field.';
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Reason for Transfer"; Rec."Reason for Transfer")
                {

                }
                field("New Department name"; Rec."New Department name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                    Visible = false;

                }



                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                    Visible = false;
                }
                field("New User"; Rec."New User")
                {
                    ApplicationArea = all;
                }
                field("New User Name"; Rec."New User Name")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("New Location"; Rec."New Location")
                {
                    ApplicationArea = ALL;
                    //Editable = false;
                }



            }
            group("Current Details")
            {
                field("Current User"; Rec."Current User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current User field.';
                    Editable = false;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Location field.';
                    Editable = false;
                }
                field("Current Condition"; Rec."Current Condition")
                {
                    ApplicationArea = all;

                }
                field("Current Name"; Rec."Current Name")
                {
                    Caption = 'Current Department';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Name field.';
                    Editable = false;
                }


            }
        }

    }
    actions
    {
        area(processing)
        {
            group("<Action1102755006>")
            {
                Caption = '&Functions';
                action("<Action1102755024>")
                {
                    Caption = 'Post';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec.Posted = false then begin
                            PostAssetMovement();

                        end else
                            Error('The Document is already Posted');
                    end;





                }
                separator(______________)
                {

                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    RunObject = Page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("No.");
                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Init Code";
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                    begin

                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Init Code";
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                    begin
                        showmessage := true;
                        // CancelCommitment();
                        // ApprovalMgt.OnCancelPVSForApproval(Rec);
                    end;
                }
            }
        }
    }
    var
        AssLedger1: Record "Asset Movement Ledgers";
        usersetup: Record "User Setup";
        ObjEmp: record "HRM-Employee (D)";

    trigger OnOpenPage()

    begin


    end;

    procedure PostAssetMovement()
     FA: Record "Fixed Asset";


    begin
        AssLedger1.reset;
        AssLedger1.SetRange("Document Nos", Rec."No.");
        AssLedger1.SetFilter(Reversed, '%1', false);
        if not AssLedger1.FindFirst() then begin
            AssLedger1.Init();
            AssLedger1."Entry No" := GetLastassetMLedgerEntryNo() + 1;
            AssLedger1."Document Nos" := Rec."No.";
            AssLedger1."Document Date" := Rec."Document Date";
            AssLedger1."FA No" := Rec."Asset No";
            AssLedger1."Current Location" := Rec."Current Location";
            AssLedger1."FA Posting Group" := Rec."FA Posting Group";
            AssLedger1."New Location" := Rec."New Location";
            AssLedger1."Reason 1 For Transfer" := Rec."Reason for Transfer";
            AssLedger1."Reason 2 For Transfer" := Rec."Reason 2 for Transfer";
            AssLedger1."Current User" := Rec."Current User";
            AssLedger1."New User" := Rec."New User";
            AssLedger1."Asset description" := Rec."Asset Description";
            AssLedger1."Current Location" := Rec."Current Location";
            AssLedger1."Current Department " := Rec."Current  Dimension 2 Code";
            AssLedger1."New Department " := Rec."New Shortcut Dimension 2 Code";
            AssLedger1.Insert()


        end;
        FA.reset;
        FA.SetRange("No.", Rec."Asset No");
        if FA.FindFirst() then begin
            FA."Current Location" := Rec."Current Location";
            FA."FA Location Code" := Rec."New Location";
            fa."Responsible Officer" := Rec."New User";
            FA.Modify()
        end;
        Rec.Posted := true;

        Message('Asset Movement POsted Succesfull');


    end;

    procedure GetLastassetMLedgerEntryNo(): Integer;
    var
        AssLedger: Record "Asset Movement Ledgers";
    begin
        AssLedger.Reset();
        if AssLedger.FindLast() then
            exit(AssLedger."Entry No")
        else
            exit(0);
    end;


}
