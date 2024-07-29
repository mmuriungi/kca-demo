page 54991 "PROC-Store Req.-Approved"
{
    CardPageID = "PROC-Store Req. Header (B)";
    PageType = List;
    SourceTable = "PROC-Store Requistion Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = All;
                }
                field("Request Description"; Rec."Request Description")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = All;
                }
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                }
                field(Justification; Rec.Justification)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = All;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = All;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                    ApplicationArea = All;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = All;
                }
                field("Store Requisition Type"; Rec."Store Requisition Type")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field(Committed; Rec.Committed)
                {
                    ApplicationArea = All;
                }
                field("SRN.No"; Rec."SRN.No")
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
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Store Requisition")
                {
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        IF Rec.Status = Rec.Status::Posted THEN
                            ERROR('The Document Has Already been Posted');

                        IF Rec.Status <> Rec.Status::Released THEN
                            ERROR('The Document Has not yet been Approved');



                        Rec.TESTFIELD("Issuing Store");
                        ReqLine.RESET;
                        ReqLine.SETRANGE(ReqLine."Requistion No", Rec."No.");
                        ReqLine.SETFILTER(ReqLine."Quantity To Issue", '>%1', 0);
                        Rec.TESTFIELD("Issuing Store");
                        IF ReqLine.FIND('-') THEN BEGIN
                            IF InventorySetup.GET THEN BEGIN
                                //  ERROR('1');
                                //             InventorySetup.TESTFIELD(InventorySetup."Item Issue Template");
                                //InventorySetup.TESTFIELD(InventorySetup."Item Issue Batch");
                                GenJnline.RESET;
                                //GenJnline.SETRANGE(GenJnline."Journal Template Name",InventorySetup."Item Issue Template");
                                //GenJnline.SETRANGE(GenJnline."Journal Batch Name",InventorySetup."Item Issue Batch");
                                IF GenJnline.FIND('-') THEN GenJnline.DELETEALL;
                            END;
                            REPEAT
                            BEGIN
                                //Issue
                                LineNo := LineNo + 1000;

                                GenJnline.INIT;
                                //GenJnline."Journal Template Name":=InventorySetup."Item Issue Template";
                                //GenJnline."Journal Batch Name":=InventorySetup."Item Issue Batch";
                                GenJnline."Line No." := LineNo;
                                GenJnline."Entry Type" := GenJnline."Entry Type"::"Negative Adjmt.";
                                GenJnline."Document No." := Rec."No.";
                                GenJnline."Item No." := ReqLine."No.";
                                GenJnline.VALIDATE("Item No.");
                                GenJnline."Location Code" := Rec."Issuing Store";
                                GenJnline.VALIDATE("Location Code");
                                GenJnline."Posting Date" := Rec."Request date";
                                GenJnline.Description := ReqLine.Description;
                                //GenJnline.Quantity:=ReqLine.Quantity;
                                GenJnline.Quantity := ReqLine."Quantity To Issue";
                                GenJnline."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                GenJnline.VALIDATE("Shortcut Dimension 1 Code");
                                GenJnline."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnline.VALIDATE("Shortcut Dimension 2 Code");
                                GenJnline.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnline.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                GenJnline.VALIDATE(Quantity);
                                GenJnline.VALIDATE("Unit Amount");
                                GenJnline."Reason Code" := '221';
                                GenJnline.VALIDATE("Reason Code");
                                GenJnline.INSERT(TRUE);

                                ReqLine."Quantity Issued" := ReqLine."Quantity Issued" + ReqLine."Quantity To Issue";
                                ReqLine."Quantity To Issue" := 0;

                                IF ReqLine."Quantity Issued" = ReqLine."Quantity Requested" THEN
                                    ReqLine."Request Status" := ReqLine."Request Status"::Closed;
                                ReqLine.MODIFY;
                            END;
                            UNTIL ReqLine.NEXT = 0;
                            //Post Entries
                            GenJnline.RESET;
                            //GenJnline.SETRANGE(GenJnline."Journal Template Name",InventorySetup."Item Issue Template");
                            //
                            //GenJnline.SETRANGE(GenJnline."Journal Batch Name",InventorySetup."Item Issue Batch");
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", GenJnline);
                            //End Post entries

                            //Modify All

                            Post := JournlPosted.PostedSuccessfully();
                            IF Post THEN
                                ReqLine.MODIFYALL(ReqLine."Request Status", ReqLine."Request Status"::Closed);

                        END;

                        Post := TRUE;
                        ReqLine.RESET;
                        ReqLine.SETRANGE(ReqLine."Requistion No", Rec."No.");
                        IF ReqLine.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                IF ReqLine."Quantity Issued" <> ReqLine."Quantity Requested" THEN
                                    IF (Post = TRUE) THEN
                                        Post := FALSE;
                            END;
                            UNTIL ReqLine.NEXT = 0;
                        END;
                        IF Post = TRUE THEN BEGIN
                            Rec.Status := Rec.Status::Posted;
                            Rec.MODIFY;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                separator(separate)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::Requisition;
                        ApprovalEntries.Setfilters(DATABASE::"PROC-Store Requistion Header", DocumentType, Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
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
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        State := State::Open;
                        IF Rec.Status <> Rec.Status::"Pending Approval" THEN State := State::"Pending Approval";
                        DocType := DocType::Requisition;
                        CLEAR(tableNo);
                        tableNo := DATABASE::"PROC-Store Requistion Header";
                        //IF ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State,"Responsibility Center",0) THEN;
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
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        DocType := DocType::Requisition;
                        showmessage := TRUE;
                        ManualCancel := TRUE;
                        CLEAR(tableNo);
                        tableNo := DATABASE::"PROC-Store Requistion Header";
                        /* IF ApprovalMgt.CancelApproval(tableNo, DocType, Rec."No.", showmessage, ManualCancel) THEN; */
                    end;
                }
                separator(seprate)
                {
                }
                action("Check Budget Availlabilty")
                {
                    Caption = 'Check Budget Availlabilty';
                    Image = Check;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;
                        IF (Rec."Issuing Store" <> 'CENTRAL') AND (Rec."Issuing Store" <> 'GENERAL') THEN
                            ERROR('This function is only applicable to Central Stores')
;
                        //IF Status=Status::Released THEN
                        //  ERROR('This document has already been released. This functionality is available for open documents only');
                        //IF NOT SomeLinesCommitted THEN BEGIN
                        //   IF NOT CONFIRM( 'Some or All the Lines Are already Committed do you want to continue',TRUE, "Document Type") THEN
                        //        ERROR('Budget Availability Check and Commitment Aborted');
                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DELETEALL;
                        //END;

                        //IF "Requisition Type"="Requisition Type"::Stationery THEN

                        // Commitment.CheckStaffClaim(Rec)
                        //ELSE
                        // ERROR('Please note that only Stationery Items are voted');

                        Rec.Committed := TRUE;
                        Rec.MODIFY;
                        MESSAGE('Budget Availability Checking Complete');
                    end;
                }
                separator(sep)
                {
                }
                action("Cancel Budget Commitments")
                {
                    Caption = 'Cancel Budget Commitments';
                    Image = CancelLine;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Committed);
                        IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE) THEN
                            ERROR('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DELETEALL;
                        //Tag all the SRN entries as Uncommitted
                        Rec.Committed := FALSE;
                        Rec.MODIFY;
                        MESSAGE('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
                separator(sprate)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = PreviewChecks;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(51271, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                separator(sprt)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        // SETFILTER("User ID",USERID);
    end;

    var
        UserMgt: Codeunit "User Setup Management BR";
        ApprovalMgt: Codeunit 439;
        ReqLine: Record "PROC-Store Requistion Lines";
        InventorySetup: Record 313;
        GenJnline: Record 83;
        LineNo: Integer;
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record 5600;
        //MinorAssetsIssue: Record "FIN-Minor Ass. Issue & Returns";
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "FIN-Budgetary Control Setup";
        DeleteCommitment: Record "FIN-Committment";
        Loc: Record 14;
        ApprovalEntries: Page 658;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "PROC-Store Requistion Lines";
    begin
        HasLines := FALSE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines."Requistion No", Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;


    procedure UpdateControls()
    begin

        /* IF Status<>Status::Released THEN BEGIN
         CurrForm."Issue Date".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
             END ELSE BEGIN
         CurrForm."Issue Date".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END;
            IF Status=Status::Open THEN BEGIN
         CurrForm."Global Dimension 1 Code".EDITABLE:=TRUE;
         CurrForm."Request date" .EDITABLE:=TRUE;
         CurrForm."Responsibility Center" .EDITABLE:=TRUE;
         CurrForm."Issuing Store" .EDITABLE:=TRUE;
         CurrForm."Request Description".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=TRUE;
         CurrForm."Request Description".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=TRUE;
         CurrForm."Required Date".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         CurrForm."Global Dimension 1 Code".EDITABLE:=FALSE;
         CurrForm."Request Description".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=FALSE;
         CurrForm."Required Date".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=FALSE;
         CurrForm."Required Date".EDITABLE:=FALSE;
          CurrForm."Request date".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END
         */

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}

