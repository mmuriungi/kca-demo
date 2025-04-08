page 50189 "Risk Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Reject';
    SourceTable = "Risk Header";
    //
    layout
    {
        area(content)
        {
            group(General)
            {
                // Editable = RiskManager;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                label("Raised By:")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Created By"; Rec."Created By")
                {
                    Caption = 'User ID';
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Employee Email"; Rec."Employee Email")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Station Code"; Rec."Station Code")
                {
                    Editable = true;
                }
                field("Station Name"; Rec."Station Name")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field(Region; Rec.Region)
                {
                    Visible = false;
                }
                field("Risk No"; Rec."Risk No")
                {
                    Editable = false;
                    Caption = 'Department Risk No';
                }
                field("Region Risk No"; Rec."Region Risk No")
                {
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    Caption = 'Risk Period';
                }


                field("Risk Opportunity Assessment"; Rec."Risk Opportunity Assessment")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = Rec."Type" = Rec."Type"::"Risk Opportunity";
                }


                field(Auditor; Rec.Auditor)
                {
                    ApplicationArea = All;
                    Caption = 'Risk Owner No';
                    // Editable = RiskManager;
                }
                field("Auditor Name"; Rec."Auditor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Owner Name';
                }
                field("Auditor Emai"; Rec."Auditor Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Owner Email';
                }
                // field("HOD User ID"; "HOD User ID")
                // {
                //     Caption = 'Risk Department Champion';
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }

                field("Review Date"; Rec."Review Date")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Description"; Rec."Risk Description2")
                {
                    Caption = 'Objective';
                    // MultiLine = true;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    Editable = Rec."Document Status" = Rec."Document Status"::"Risk Manager";
                }
                field("Reason For Changes"; Rec."Reason For Changes")
                {
                    Editable = Rec."Document Status" = Rec."Document Status"::"Risk Owner";
                }
            }
            part("Risk Details"; "Risk Details")
            {
                SubPageLink = "Risk No." = field("No.");
            }
            group(RiskDefinition)
            {
                //  Caption = 'Risk Details';


                field("Root Cause Analysis"; RootCauseTxt)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Risk Description");
                        "Root Cause Analysis".CREATEINSTREAM(Instr);
                        RootCauseBigTxt.READ(Instr);

                        IF RootCauseTxt <> FORMAT(RootCauseBigTxt) THEN BEGIN
                            CLEAR(Rec."Root Cause Analysis");
                            CLEAR(RootCauseBigTxt);
                            RootCauseBigTxt.ADDTEXT(RootCauseTxt);
                            "Root Cause Analysis".CREATEOUTSTREAM(OutStr);
                            RootCauseBigTxt.WRITE(OutStr);
                        END;
                    end;
                }
                field("Mitigation Suggestions"; MitigationTxt)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Mitigation Suggestions");
                        "Mitigation Suggestions".CREATEINSTREAM(Instr);
                        MitigationBigTxt.READ(Instr);

                        IF MitigationTxt <> FORMAT(MitigationBigTxt) THEN BEGIN
                            CLEAR(Rec."Mitigation Suggestions");
                            CLEAR(MitigationBigTxt);
                            MitigationBigTxt.ADDTEXT(MitigationTxt);
                            "Mitigation Suggestions".CREATEOUTSTREAM(OutStr);
                            MitigationBigTxt.WRITE(OutStr);
                        END;
                    end;
                }

            }

            group("Risk Assessment")
            {
                Editable = NewVisible;
                Visible = false;
                Caption = 'Assesment & Valuation';
                group("GROSS CATEGORY")
                {
                    field("Risk Category"; Rec."Risk Category")
                    {
                        Caption = 'Risk Category';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Category Description"; Rec."Risk Category Description")
                    {
                        Caption = 'Risk Category Description';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Risk Type"; Rec."Risk Type")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("Risk Type Description"; Rec."Risk Type Description")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                }
                group("GROSS RISK")
                {
                    group("RISK VALUE")
                    {
                        field("Value at Risk (Amount)"; Rec."Value at Risk")
                        {
                            Caption = 'Value at Risk';
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    field("Risk Probability"; Rec."Risk Probability")
                    {
                        Caption = 'Risk probability(%)';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Likelihood Value"; Rec."Risk Likelihood Value")
                    {
                        Caption = 'Likelihood Score';
                        Editable = false;
                    }
                    field("Risk Likelihood"; Rec."Risk Likelihood")
                    {
                        Caption = 'Risk Likelihood';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Risk Impact Value"; Rec."Risk Impact Value")
                    {
                        Caption = 'Impact Score';
                        Editable = false;
                    }
                    field("Risk Impact"; Rec."Risk Impact")
                    {
                        Caption = 'Risk Impact';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Risk (L * I)"; Rec."Risk (L * I)")
                    {
                        Caption = 'Gross Risk Score';
                        Editable = false;
                    }
                    field("RAG Status"; Rec."RAG Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                }
                group(ControlGroup)
                {

                    Caption = 'RISK CONTROL';
                    Visible = ChampionEditable;
                    field("Existing Risk Controls"; ExistingTxt)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        trigger OnValidate()
                        begin
                            Rec.CALCFIELDS("Existing Risk Controls");
                            "Existing Risk Controls".CREATEINSTREAM(Instr);
                            ExistingBigTxt.READ(Instr);

                            IF ExistingTxt <> FORMAT(ExistingBigTxt) THEN BEGIN
                                CLEAR(Rec."Existing Risk Controls");
                                CLEAR(ExistingBigTxt);
                                ExistingBigTxt.ADDTEXT(ExistingTxt);
                                "Existing Risk Controls".CREATEOUTSTREAM(OutStr);
                                ExistingBigTxt.WRITE(OutStr);
                            END;
                        end;
                    }
                    field("Additional mitigation controls"; Rec."Additional mitigation controls")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Mitigation Owner"; Rec."Mitigation Owner")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Controls)
                {
                    field("Value after Control"; Rec."Value after Control")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Control Risk Probability"; Rec."Control Risk Probability")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("Control Evaluation Likelihood"; Rec."Control Evaluation Likelihood")
                    {
                        Caption = 'Control risk likelihood value';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control Risk Likelihood"; Rec."Control Risk Likelihood")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Control Evaluation Impact"; Rec."Control Evaluation Impact")
                    {
                        Caption = 'Control risk impact value';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control Risk Impact"; Rec."Control Risk Impact")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Control Risk (L * I)"; Rec."Control Risk (L * I)")
                    {
                        Caption = 'Control Gross risk';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control RAG Status"; Rec."Control RAG Status")
                    {
                        Editable = false;
                    }
                }


                group("RESIDUAL RISK")
                {

                    field("Residual Value"; Rec."Residual Value")
                    {
                        Editable = false;
                    }
                    field("Residual Risk Likelihood"; Rec."Residual Risk Likelihood")
                    {
                        Caption = 'Residual Likelihood Value';
                        Editable = false;
                    }
                    field("Residual Risk Likelihood Cat"; Rec."Residual Risk Likelihood Cat")
                    {
                        Editable = false;
                    }
                    field("Residual Likelihood Impact"; Rec."Residual Likelihood Impact")
                    {
                        Caption = 'Residual Impact Value';
                        Editable = false;
                    }
                    field("Residual Risk Impact"; Rec."Residual Risk Impact")
                    {
                        Editable = false;
                    }
                    field("Residual Risk (L * I)"; Rec."Residual Risk (L * I)")
                    {
                        Caption = 'Residual Risk Score';
                        Editable = false;
                    }
                    field("Residual RAG Status"; Rec."Residual RAG Status")
                    {
                        Editable = false;
                    }
                }
                group("Others")
                {
                    ShowCaption = false;
                    Visible = ChampionEditable;
                    field("Risk Response"; Rec."Risk Response")
                    {
                        Caption = 'Acceptance Decision';
                    }
                    field(Comment; Rec.Comment)
                    {

                    }
                }

            }
            part(RiskKRIs; "Risk KRI(s)")
            {
                Editable = NewVisible;
                Caption = 'Risk KRI(s)';
                Visible = false;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No."), Type = CONST("KRI(s)");
            }


        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
            }

            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Documents")
                {
                    ApplicationArea = all;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = Rec."No." <> '';

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        PgDocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(PgDocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        PgDocumentAttachment.OpenForRecReference(RecRef);
                        if Rec.Status = Rec.Status::Released then
                            PgDocumentAttachment.Editable(false);
                        PgDocumentAttachment.RUNMODAL;
                    end;
                }
            }
            action("Send To Risk Owner")
            {
                Caption = 'Send To Risk Owner';
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Document Status" = Rec."Document Status"::New;


                trigger OnAction()
                var
                    RiskLine: Record "Risk Line";
                begin
                    // TestField("Risk Description");
                    //  TestField("Risk Region");
                    RiskLine.RESET;
                    RiskLine.SETRANGE("Document No.", Rec."No.");
                    RiskLine.SETFILTER(Type, '%1|%2|%3', RiskLine.Type::"KRI(s)", RiskLine.Type::Response, RiskLine.Type::"Risk Category");
                    // IF NOT RiskLine.FINDFIRST() THEN Error('Please specify the risk KRI(s)');
                    RegistrationMgt.FnReportRisk(Rec, Rec."Auditor Email");
                    CurrPage.CLOSE;
                    //
                end;
            }
            action("Send To Auditor")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Document Status" = Rec."Document Status"::"Risk Owner";
                Caption = 'Send to Risk Manager';

                trigger OnAction()
                var
                    RiskHeader: Record "Risk Header";
                begin
                    // Filter to the current risk header
                    RiskHeader.Reset();
                    RiskHeader.SetRange("No.", Rec."No.");

                    if RiskHeader.FindFirst() then begin
                        // Call the function to send the email to the Risk Manager
                        RegistrationMgt.FnSendToRiskManagers(RiskHeader."No.");

                        Message('Sent successfully to Risk Manager.');

                        // Close the page after successful processing
                        CurrPage.CLOSE;
                    end else
                        Error('Risk Header not found.');
                end;
            }


            action(ShowLinks)
            {
                Caption = 'Show Links';
                Image = Link;
                ApplicationArea = Basic, Suite;
                Promoted = false;
                Visible = not LinksVisible;

                trigger OnAction()
                begin
                    ShowLinksPage();
                end;
            }
            action(HideLinks)
            {
                Caption = 'Hide Links';
                Image = Link;
                ApplicationArea = Basic, Suite;
                Promoted = false;
                Visible = LinksVisible;

                trigger OnAction()
                begin
                    HidePageLinks();
                end;
            }
            action("Consolidate")
            {
                Image = Migration;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Document Status" = Rec."Document Status"::"Risk Manager";
                trigger OnAction()
                var
                    RiskHeader: Record "Risk Header";
                begin
                    RiskHeader.Reset();
                    RiskHeader.SetRange(RiskHeader."No.", Rec."No.");
                    if RiskHeader.FindFirst() then begin
                        RiskHeader.fnConsolidateRisk();
                        Message('Transfered Successfully');
                    end;
                end;
            }
            action("Return To Riks Owner")
            {
                Image = return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Document Status" = Rec."Document Status"::"Risk Manager";
                trigger OnAction()
                var
                    RiskHeader: Record "Risk Header";
                begin
                    RiskHeader.Reset();
                    RiskHeader.SetRange(RiskHeader."No.", Rec."No.");
                    if RiskHeader.FindFirst() then begin
                        if RiskHeader."Document Status" = RiskHeader."Document Status"::"Risk Manager" then
                            RiskHeader."Document Status" := RiskHeader."Document Status"::"Risk Owner";
                        RiskHeader.Modify();
                        Message('Sent Successfully');
                        CurrPage.CLOSE;
                    end;

                end;

            }
            action("Escalate")
            {
                Visible = false;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    AuditMgt.SendMailtoRiskChampion2(Rec);
                    Rec.Modify(true);
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;//(Status = Status::New);// or (Status = Status::"Pending Approval");
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit ApprovalMgtCuExtension;
                begin
                    if ApprovalsMgmt.CheckRiskHeaderWorkflowEnabled(Rec) then begin
                        ApprovalsMgmt.OnSendRiskHeaderForApproval(Rec);
                        Commit();
                        CurrPage.Close();
                    end;
                end;
            }

            action(Reject)
            {
                Caption = 'Reject Risk';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec."Document Status" = Rec."Document Status"::"Risk Owner";

                trigger OnAction()
                begin
                    if Rec."Rejection Reason" = '' then
                        Error('Please input reject reason');
                    AuditMgt.NotifySenderOnChanges(Rec);
                    Rec."Document Status" := Rec."Document Status"::New;
                    RegistrationMgt.FnRejectRisk(Rec, Rec."Employee Email");
                    Rec.Modify();
                    CurrPage.CLOSE;
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::"Risk Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        CheckVisibility;
        SetControlAppearance();

        Rec.CALCFIELDS("Risk Description", "Root Cause Analysis", "Mitigation Suggestions", "Existing Risk Controls");
        "Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);

        "Root Cause Analysis".CREATEINSTREAM(Instr);
        RootCauseBigTxt.READ(Instr);
        RootCauseTxt := FORMAT(RootCauseBigTxt);

        "Mitigation Suggestions".CREATEINSTREAM(Instr);
        MitigationBigTxt.READ(Instr);
        MitigationTxt := FORMAT(MitigationBigTxt);

        "Existing Risk Controls".CREATEINSTREAM(Instr);
        ExistingBigTxt.READ(Instr);
        ExistingTxt := FORMAT(ExistingBigTxt);
        FnEditable();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        CheckVisibility;
        FnEditable();
    end;

    var
        NewVisible: Boolean;
        ChampionEditable: Boolean;
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        RootCauseBigTxt: BigText;
        RootCauseTxt: Text;
        MitigationBigTxt: BigText;

        ApprovalsMgmt: Codeunit ApprovalMgtCuExtension;
        MitigationTxt: Text;
        ExistingBigTxt: BigText;
        ExistingTxt: Text;
        AuditMgt: Codeunit "Internal Audit Management";
        RegistrationMgt: Codeunit "Registration Payment Process";
        UserSetup: Record "User Setup";
        SendToRegister: Boolean;
        SendToHOD: Boolean;
        SendToChampion: Boolean;
        SendToPM: Boolean;
        SendBackToChamp: Boolean;
        CurrUserCanEdit: Boolean;
        RiskAssessment: Boolean;
        RiskManager: Boolean;
        RiskME: Boolean;
        RiskResponse: Boolean;
        RiskValue: Boolean;
        RiskOpportunity: Boolean;
        [InDataSet]
        LinksVisible: Boolean;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RiskSetup: Record "Audit Setup";
    begin
        Rec."Plan Type" := Rec."Plan Type"::"Department Plan";
        RiskSetup.Get();
        Rec."Current Disposal" := RiskSetup."Current Risk Plan";
    end;

    local procedure CheckVisibility()
    begin
        HidePageLinks();

        case Rec."Document Status" of
            Rec."Document Status"::New:
                begin
                    SendToRegister := false;
                    SendToChampion := true;
                end;
            Rec."Document Status"::Champion:
                begin
                    SendToRegister := true;
                    SendToChampion := false;
                end;
            Rec."Document Status"::Closed:
                begin
                    SendToRegister := false;
                    SendToChampion := false;
                end;
        end;
    end;

    procedure SetControlAppearance()
    begin
        if (Rec."Document Status" = Rec."Document Status"::New) then
            NewVisible := true
        else
            NewVisible := false;

        if (Rec."Document Status" = Rec."Document Status"::Champion) or (Rec."Document Status" = Rec."Document Status"::"Risk Owner") then
            ChampionEditable := true
        else
            ChampionEditable := false;

    end;

    procedure FnEditable()
    var
        ObjRiskChamps: record "Internal Audit Champions";
    begin
        if Rec."Document Status" = Rec."Document Status"::"Risk Owner" then begin
            if Rec."Reason For Changes" <> '' then
                RiskManager := true
            else
                RiskManager := false;

        end;
    end;

    procedure ShowLinksPage()
    begin
        LinksVisible := true;
    end;

    procedure HidePageLinks()
    begin
        LinksVisible := false;
    end;

    procedure ReleaseRiskHeader(var RiskHeaderRec: Record "Risk Header")
    var
        RiskHeader: Record "Risk Header";
    begin
        if RiskHeader.Get(RiskHeaderRec."No.") then begin
            // RiskHeader."Status" := RiskHeader."Status"::Released;
            if RiskHeader."Plan Type" = RiskHeader."Plan Type"::"Department Plan" then begin
                if RiskHeader.fnConsolidateRisk then
                    RiskHeader."Sent to HQ" := true;
            end;
            if RiskHeader."Document Status"::Champion = RiskHeader."Document Status"::New then
                RiskHeader."Document Status" := RiskHeader."Document Status"::"Risk Manager";
            RiskHeader.Modify(true);
            if RiskHeader."Plan Type" = RiskHeader."Plan Type"::"Organizational Plan" then begin
                RiskHeader."Consolidateion Date" := WorkDate();
            end;
            if RiskHeader."Document Status"::Champion = RiskHeader."Document Status"::New then
                RiskHeader."Document Status" := RiskHeader."Document Status"::"Risk Manager";
            RiskHeader.Modify(true);
        end;
    end;
}

