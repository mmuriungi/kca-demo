page 50865 "FIN-Memo Header Card"
{
    PageType = Card;
    SourceTable = "FIN-Memo Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = setEditable;
                field("Date/Time"; Rec."Date/Time")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("To"; Rec."To")
                {

                }
                field(Through; Rec.Through)
                {
                }
                field(From; Rec.From)
                {
                }

                field("REF."; Rec."Title/Ref.")
                {
                }
                field(Title; Rec.Title)
                {

                }
                field("Paragraph 1"; Rec."Paragraph 1")
                {
                    MultiLine = true;
                }
                field("Paragraph 2"; Rec."Paragraph 2")
                {
                    MultiLine = true;
                }
                field("Paragraph 3"; Rec."Paragraph 3")
                {
                    MultiLine = true;
                    visible = false;
                }
                field("Department Code"; Rec.Institution)
                {
                }
                field("Activity Code"; Rec."Department Code")
                {
                }
                field("Budget Account"; Rec."Budget Account")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Compute P.A.Y.E."; Rec."Compute P.A.Y.E.")
                {
                    Visible = false;

                }
                field("P.A.Y.E. Rate"; Rec."P.A.Y.E. Rate")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }

                field("Memo Status"; Rec."Memo Status")
                {
                    Editable = false;
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        if Rec."Memo Status" = Rec."Memo Status"::Approved then begin
                            Rec."Memo Used" := true;
                            Rec.Modify;
                        end;
                    end;
                }
                field("Memo Used"; Rec."Memo Used")
                {
                    Editable = false;
                    Enabled = false;

                }
                field(PRN; Rec.PRN)
                {
                    visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }

                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                }
                field("Created by"; Rec."Created by")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("PRN No."; Rec."PRN No.")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }

                field("Associated Document No."; Rec."Associated Document No.")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Associated Document Type"; Rec."Associated Document Type")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Memo Value"; Rec."Memo Value")
                {
                    Editable = false;
                    Enabled = false;
                }
                part(part; "Memo PRN Details")
                {
                    /*  Editable = setEditable2;
                     Enabled = setEditable2; */
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(ExpCodes)
            {
                Caption = 'Roles';
                ApplicationArea = All;
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "FIN-Memo Expense Codes";
                RunPageLink = "Memo No." = FIELD("No.");
            }
            action(MemRep)
            {
                ApplicationArea = All;
                Caption = 'Memo Report';
                Image = Continue;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    cashoff: Record "Cash Office Setup";
                begin
                    cashoff.Get();
                    Rec."Budget Name" := cashoff."Current Budget";
                    Rec."Budgeted Amount2" := Rec."Budgeted Amount";
                    Rec."Committed Amount2" := Rec."Committed Amount" * -1;
                    Rec."Expensed Amount2" := Rec."Expensed Amount" * -1;
                    FINMemoHeader.RESET;
                    FINMemoHeader.SETRANGE("No.", Rec."No.");
                    IF FINMemoHeader.FIND('-') THEN BEGIN
                        REPORT.RUN(50877, TRUE, FALSE, FINMemoHeader);
                    END;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ApprovalEntries.Setfilters(DATABASE::"FIN-Memo Header", 8, Rec."No.");
                    ApprovalEntries.RUN;
                end;
            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Code";
                begin
                    //  ApprovalMgt.OnSendMemoforApproval(Rec);
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Code";
                begin
                    //ApprovalMgt.OnCancelMemoForApproval(Rec);
                end;
            }
            action(MarkPost)
            {
                ApplicationArea = All;
                Caption = 'Mark Posted';
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF Rec."Memo Status" <> Rec."Memo Status"::Approved THEN ERROR('Status must be Approved!');
                    IF CONFIRM('Mark as Posted?', FALSE) = FALSE THEN ERROR('Posting Cancelled!');
                    Rec."Memo Status" := Rec."Memo Status"::Posted;
                end;
            }
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'EDMS Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page 1173;
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Memo Status" = Rec."Memo Status"::Pending THEN setEditable := TRUE ELSE setEditable := FALSE;
        IF Rec.PRN THEN setEditable2 := TRUE ELSE setEditable2 := FALSE;
    end;

    trigger OnInit()
    begin
        IF Rec."Memo Status" = Rec."Memo Status"::Pending THEN setEditable := TRUE ELSE setEditable := FALSE;
        IF Rec.PRN THEN setEditable2 := TRUE ELSE setEditable2 := FALSE;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec.PRN THEN setEditable2 := TRUE ELSE setEditable2 := FALSE;
    end;

    var
        FINMemoHeader: Record "FIN-Memo Header";
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        DateEquivalent: Date;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Farmer Application",Vehicle_Reg,"Sales Returns","Transfer Order",Payroll,"Casual Payroll",Memo;
        ApprovalEntries: Page "Approval Entries";
        setEditable: Boolean;
        setEditable2: Boolean;
#pragma warning disable AL0432
        //  SendMail: Codeunit 400;
#pragma warning restore AL0432
#pragma warning disable AL0432
        // SMTPMailSetup: Record 409;
#pragma warning restore AL0432
        //Mail: DotNet SmtpMessage;
        FinImprestHeader: Record "FIN-Imprest Header";
        FinImprestLines: Record "FIN-Imprest Lines";
        FinMemoDetails: Record "FIN-Memo Details";
        FinMemoDetails2: Record "FIN-Memo Details";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit 396;

    local procedure CommitBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
        FINMemoDetails: Record "FIN-Memo Details";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Payroll Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD(BCSetup."Current Budget Code");
        Rec.TESTFIELD(Institution);
        Rec.TESTFIELD("Department Code");
        Rec.TESTFIELD("Budget Account");

        FINMemoDetails.RESET;
        FINMemoDetails.SETRANGE("Memo No.", Rec."No.");
        IF FINMemoDetails.FIND('-') THEN FINMemoDetails.CALCSUMS(Amount);
        // Check if budget exists
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", Rec."Budget Account");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec.Institution);
        //   DimensionValue.SETRANGE("Global Dimension No.",2);
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        FINBudgetEntries.RESET;
        FINBudgetEntries.SETRANGE(FINBudgetEntries."Budget Name", BCSetup."Current Budget Code");
        FINBudgetEntries.SETRANGE(FINBudgetEntries."G/L Account No.", Rec."Budget Account");
        FINBudgetEntries.SETRANGE(FINBudgetEntries."Global Dimension 1 Code", Rec.Institution);
        FINBudgetEntries.SETRANGE(FINBudgetEntries."Global Dimension 2 Code", Rec."Department Code");
        FINBudgetEntries.SETFILTER(FINBudgetEntries."Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
        , FINBudgetEntries."Transaction Type"::Allocation);
        FINBudgetEntries.SETFILTER(FINBudgetEntries."Commitment Status", '%1|%2',
        FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
        CLEAR(DateEquivalent);
        IF EVALUATE(DateEquivalent, FORMAT(Rec."Date/Time")) THEN;
        FINBudgetEntries.SETFILTER(FINBudgetEntries.Date, PostBudgetEnties.GetBudgetStartAndEndDates(DateEquivalent));
        IF FINBudgetEntries.FIND('-') THEN BEGIN
            IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                IF FINBudgetEntries.Amount > 0 THEN BEGIN
                    IF (FINMemoDetails.Amount > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                    // Commit Budget Here
                    //          PostBudgetEnties.CheckBudgetAvailability(Rec."Budget Account",DateEquivalent,Rec."Programme Code",Rec."Department Code",Rec."Activity Code",
                    //          FINMemoDetails.Amount,'','MEMO',Rec."No."+Rec."Budget Account",'MEMO');
                    PostBudgetEnties.CheckBudgetAvailability(Rec."Budget Account", DateEquivalent, Rec."Department Code", '',
                    FINMemoDetails.Amount, '', 'MEMO', Rec."No." + Rec."Budget Account", 'MEMO', Rec.From);
                END ELSE
                    ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
            END;
            //END  ELSE ERROR('Missing Budget for  Account:'+GLAccount.Name+', Department:'+DimensionValue.Name);
        END ELSE
            ERROR('Missing Budget for  Account:' + GLAccount.Name + ', For your department');
    end;

    local procedure ExpenseBudget()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        PostBudgetEnties: Codeunit "Post Budget Enties";
        FINMemoDetails: Record "FIN-Memo Details";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Payroll Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD(Institution);
        Rec.TESTFIELD("Department Code");
        Rec.TESTFIELD("Budget Account");
        //Get Current Lines to loop through
        // Expense Budget Here

        FINMemoDetails.RESET;
        FINMemoDetails.SETRANGE("Memo No.", Rec."No.");
        IF FINMemoDetails.FIND('-') THEN FINMemoDetails.CALCSUMS(Amount);
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", Rec."Budget Account");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec."Department Code");
        // DimensionValue.SETRANGE("Global Dimension No.",3);
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        IF (FINMemoDetails.Amount > 0) THEN BEGIN
            // Commit Budget Here
            //     PostBudgetEnties.ExpenseBudget(Rec."Budget Account", DateEquivalent, Rec."Department Code", Rec."Department Code", Rec."Activity Code",
            //    FINMemoDetails.Amount, GLAccount.Name, USERID, TODAY, 'MEMO', Rec."No." + Rec."Budget Account", 'MEMO');
            PostBudgetEnties.ExpenseBudget(Rec."Budget Account", DateEquivalent, Rec.Institution, Rec.Institution,
               FINMemoDetails.Amount, GLAccount.Name, USERID, TODAY, 'MEMO', Rec."No." + Rec."Budget Account", 'MEMO', Rec.From);

        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record "G/L Account";
        DimensionValue: Record "Dimension Value";
        //PostBudgetEnties: Codeunit "Post Budget Enties";
        FINMemoDetails: Record "FIN-Memo Details";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Payroll Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD(Institution);
        Rec.TESTFIELD("Department Code");
        Rec.TESTFIELD("Budget Account");
        //Get Current Lines to loop through
        // Expense Budget Here

        FINMemoDetails.RESET;
        FINMemoDetails.SETRANGE("Memo No.", Rec."No.");
        IF FINMemoDetails.FIND('-') THEN FINMemoDetails.CALCSUMS(Amount);
        // Expense Budget Here
        GLAccount.RESET;
        GLAccount.SETRANGE("No.", Rec."Budget Account");
        IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
        DimensionValue.RESET;
        DimensionValue.SETRANGE(Code, Rec."Department Code");
        DimensionValue.SETRANGE("Global Dimension No.", 3);
        IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
        IF (FINMemoDetails.Amount > 0) THEN BEGIN
            // Commit Budget Here
            //          PostBudgetEnties.CancelBudgetCommitment(Rec."Budget Account",DateEquivalent,Rec."Programme Code",Rec."Department Code",Rec."Activity Code",
            //          FINMemoDetails.Amount,GLAccount.Name,USERID,'MEMO',Rec."No."+Rec."Budget Account",'MEMO');
        END;
    end;
}

