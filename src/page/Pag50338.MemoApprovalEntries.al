page 50338 "Memo Approval Entries"
{
    Caption = 'Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry";
    //SourceTableView = WHERE("Document Type"=CONST('Memo'));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                // field("PV Narration"; "PV Narration")
                // {
                // }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                }
                field("Approval Code"; Rec."Approval Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Sender ID"; Rec."Sender ID")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
                // field("Approved The Document"; "Approved The Document")
                // {
                // }
                // field("Search Value"; "Search Value")
                // {
                // }
                // field("PV G/L Account"; "PV G/L Account")
                // {
                // }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action(Document)
                {
                    Caption = 'Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Rec.ShowDocument;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 660;
                    RunPageLink = "Table ID" = FIELD("Table ID"),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No.");
                    RunPageView = SORTING("Table ID", "Document Type", "Document No.");
                }
                action("O&verdue Entries")
                {
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;

                    trigger OnAction()
                    begin
                        Rec.SETFILTER(Status, '%1|%2', Rec.Status::Created, Rec.Status::Open);
                        Rec.SETFILTER("Due Date", '<%1', TODAY);
                    end;
                }
                action("All Entries")
                {
                    Caption = 'All Entries';
                    Image = Entries;

                    trigger OnAction()
                    begin
                        Rec.SETRANGE(Status);
                        Rec.SETRANGE("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                begin
                    IF CONFIRM('Approve?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT
                        //ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
                        UNTIL ApprovalEntry.NEXT = 0;

                    MESSAGE('Approved!');
                end;
            }
            action(Reject)
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RejectVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    //ApprovalSetup: Record "Approval Setup";
                    ApprovalCommentLine: Record "Approval Comment Line";
                    ApprovalComment: Page "Approval Comments";
                begin
                    IF CONFIRM('Reject?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    // IF ApprovalEntry.FIND('-') THEN
                    //     REPEAT
                    //         IF NOT ApprovalSetup.GET THEN
                    //             ERROR(Text004);
                    //         IF ApprovalSetup."Request Rejection Comment" = TRUE THEN BEGIN
                    //             ApprovalCommentLine.SETRANGE(Rec."Table ID", ApprovalEntry."Table ID");
                    //             ApprovalCommentLine.SETRANGE(Rec."Document Type", ApprovalEntry."Document Type");
                    //             ApprovalCommentLine.SETRANGE(Rec."Document No.", ApprovalEntry."Document No.");
                    //             ApprovalComment.SETTABLEVIEW(ApprovalCommentLine);
                    //             IF ApprovalComment.RUNMODAL = ACTION::OK THEN
                    //                 ApprovalMgt.RejectApprovalRequest(ApprovalEntry);
                    //         END ELSE
                    //             ApprovalMgt.RejectApprovalRequest(ApprovalEntry);

                    //     UNTIL ApprovalEntry.NEXT = 0;

                    MESSAGE('Rejected!');
                end;
            }
            action("&Delegate")
            {
                Caption = '&Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    TempApprovalEntry: Record 454;
                // ApprovalSetup: Record 452;
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);

                    CurrPage.SETSELECTIONFILTER(TempApprovalEntry);
                    IF TempApprovalEntry.FINDFIRST THEN BEGIN
                        TempApprovalEntry.SETFILTER(TempApprovalEntry.Status, '<>%1', TempApprovalEntry.Status::Open);
                        IF NOT TempApprovalEntry.ISEMPTY THEN
                            ERROR(Text001);
                    END;

                    // IF ApprovalEntry.FIND('-') THEN BEGIN
                    //     IF ApprovalSetup.GET THEN;
                    //     IF Usersetup.GET(USERID) THEN;
                    //     IF (ApprovalEntry."Sender ID" = Usersetup."User ID") OR
                    //        (ApprovalSetup."Approval Administrator" = Usersetup."User ID") OR
                    //        (ApprovalEntry."Approver ID" = Usersetup."User ID")
                    //     THEN
                    //         REPEAT
                    //            // ApprovalMgt.DelegateApprovalRequest(ApprovalEntry);
                    //         UNTIL ApprovalEntry.NEXT = 0;
                    // END;

                    MESSAGE(Text002);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        IF FormatField(Rec) THEN
            Overdue := Overdue::Yes;
    end;

    trigger OnInit()
    begin
        RejectVisible := TRUE;
        ApproveVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        Filterstring: Text;
    begin
        IF NOT Usersetup.GET(USERID) THEN ERROR('You dont have approval rights');
        IF Usersetup.GET(USERID) THEN BEGIN
            Rec.FILTERGROUP(2);
            Filterstring := Rec.GETFILTERS;
            Rec.FILTERGROUP(0);
            IF STRLEN(Filterstring) = 0 THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETCURRENTKEY("Approver ID");
                IF Overdue = Overdue::Yes THEN
                    Rec.SETRANGE("Approver ID", Usersetup."User ID");
                Rec.SETRANGE(Status, Rec.Status::Open);
                Rec.FILTERGROUP(0);
            END ELSE
                Rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
        END;
        Rec.SETFILTER("Approver ID", USERID);
    end;

    var
        Usersetup: Record "User Setup";
        ApprovalMgt: Codeunit 439;
        Text001: Label 'You can only delegate open approval entries.';
        Text002: Label 'The selected approval(s) have been delegated. ';
        Overdue: Option Yes," ";
        Text004: Label 'Approval Setup not found.';
        [InDataSet]
        ApproveVisible: Boolean;
        [InDataSet]
        RejectVisible: Boolean;

    //[Scope('Internal')]
    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Farmer Application",Vehicle_Reg,"Sales Returns"; DocumentNo: Code[20])
    begin
        IF TableId <> 0 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
            Rec.SETRANGE("Table ID", TableId);
            Rec.SETRANGE("Document Type", DocumentType);
            IF DocumentNo <> '' THEN
                Rec.SETRANGE("Document No.", DocumentNo);
            Rec.FILTERGROUP(0);
        END;

        ApproveVisible := FALSE;
        RejectVisible := FALSE;
    end;

    //[Scope('Internal')]
    procedure FormatField(Rec: Record 454) OK: Boolean
    begin
        IF Rec.Status IN [Rec.Status::Created, Rec.Status::Open] THEN BEGIN
            IF Rec."Due Date" < TODAY THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
    end;

    //[Scope('Internal')]
    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

