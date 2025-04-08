page 50451 "Consolidated Risk Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Reject';
    SourceTable = "Risk Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Date Created"; "Date Created")
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

                field("Created By"; "Created By")
                {
                    Caption = 'User ID';
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Audit Period"; "Audit Period")
                {
                    ApplicationArea = All;
                }
                field("Current Plan"; "Current Plan")
                {
                    ShowMandatory = true;
                }

                field(Auditor; Auditor)
                {
                    ApplicationArea = All;
                    Caption = 'Risk Manager No';
                    Visible = false;
                }
                field("Auditor Name"; "Auditor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Manager Name';
                    Visible = false;
                }
                field("Auditor Emai"; "Auditor Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Manager Email';
                    Visible = false;
                }

                field("Document Status"; "Document Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Rejection Reason"; "Rejection Reason")
                {
                    Editable = "Document Status" = "Document Status"::Champion;
                    Visible = false;
                }
                field("Risk Description"; "Risk Description")
                {
                    Caption = 'Comments';
                    Editable = true;
                }
            }

            part("Risk Details"; "Risk Details")
            {
                SubPageLink = "Risk No." = field("No.");
            }

            field("Root Cause Analysis"; RootCauseTxt)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                Visible = false;
                trigger OnValidate()
                begin
                    CALCFIELDS("Risk Description");
                    "Root Cause Analysis".CREATEINSTREAM(Instr);
                    RootCauseBigTxt.READ(Instr);

                    IF RootCauseTxt <> FORMAT(RootCauseBigTxt) THEN BEGIN
                        CLEAR("Root Cause Analysis");
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
                    CALCFIELDS("Mitigation Suggestions");
                    "Mitigation Suggestions".CREATEINSTREAM(Instr);
                    MitigationBigTxt.READ(Instr);

                    IF MitigationTxt <> FORMAT(MitigationBigTxt) THEN BEGIN
                        CLEAR("Mitigation Suggestions");
                        CLEAR(MitigationBigTxt);
                        MitigationBigTxt.ADDTEXT(MitigationTxt);
                        "Mitigation Suggestions".CREATEOUTSTREAM(OutStr);
                        MitigationBigTxt.WRITE(OutStr);
                    END;
                end;
            }

            group("Risk Assessment")
            {
                Editable = NewVisible;
                Visible = false;
                Caption = 'Assesment & Valuation';
                group("GROSS CATEGORY")
                {
                    field("Risk Category"; "Risk Category")
                    {
                        Caption = 'Risk Category';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Category Description"; "Risk Category Description")
                    {
                        Caption = 'Risk Category Description';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Risk Type"; "Risk Type")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("Risk Type Description"; "Risk Type Description")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                }
                group("GROSS RISK")
                {
                    group("RISK VALUE")
                    {
                        field("Value at Risk (Amount)"; "Value at Risk")
                        {
                            Caption = 'Value at Risk';
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    field("Risk Probability"; "Risk Probability")
                    {
                        Caption = 'Risk probability(%)';
                        ApplicationArea = Basic, Suite;
                    }
                    field("Risk Likelihood Value"; "Risk Likelihood Value")
                    {
                        Caption = 'Likelihood Score';
                        Editable = false;
                    }
                    field("Risk Likelihood"; "Risk Likelihood")
                    {
                        Caption = 'Risk Likelihood';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Risk Impact Value"; "Risk Impact Value")
                    {
                        Caption = 'Impact Score';
                        Editable = false;
                    }
                    field("Risk Impact"; "Risk Impact")
                    {
                        Caption = 'Risk Impact';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Risk (L * I)"; "Risk (L * I)")
                    {
                        Caption = 'Gross Risk Score';
                        Editable = false;
                    }
                    field("RAG Status"; "RAG Status")
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
                            CALCFIELDS("Existing Risk Controls");
                            "Existing Risk Controls".CREATEINSTREAM(Instr);
                            ExistingBigTxt.READ(Instr);

                            IF ExistingTxt <> FORMAT(ExistingBigTxt) THEN BEGIN
                                CLEAR("Existing Risk Controls");
                                CLEAR(ExistingBigTxt);
                                ExistingBigTxt.ADDTEXT(ExistingTxt);
                                "Existing Risk Controls".CREATEOUTSTREAM(OutStr);
                                ExistingBigTxt.WRITE(OutStr);
                            END;
                        end;
                    }
                    field("Additional mitigation controls"; "Additional mitigation controls")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Mitigation Owner"; "Mitigation Owner")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Controls)
                {
                    field("Value after Control"; "Value after Control")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Control Risk Probability"; "Control Risk Probability")
                    {
                        ApplicationArea = Basic, Suite;

                    }
                    field("Control Evaluation Likelihood"; "Control Evaluation Likelihood")
                    {
                        Caption = 'Control risk likelihood value';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control Risk Likelihood"; "Control Risk Likelihood")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Control Evaluation Impact"; "Control Evaluation Impact")
                    {
                        Caption = 'Control risk impact value';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control Risk Impact"; "Control Risk Impact")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }

                    field("Control Risk (L * I)"; "Control Risk (L * I)")
                    {
                        Caption = 'Control Gross risk';
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                    }
                    field("Control RAG Status"; "Control RAG Status")
                    {
                        Editable = false;
                    }
                }


                group("RESIDUAL RISK")
                {

                    field("Residual Value"; "Residual Value")
                    {
                        Editable = false;
                    }
                    field("Residual Risk Likelihood"; "Residual Risk Likelihood")
                    {
                        Caption = 'Residual Likelihood Value';
                        Editable = false;
                    }
                    field("Residual Risk Likelihood Cat"; "Residual Risk Likelihood Cat")
                    {
                        Editable = false;
                    }
                    field("Residual Likelihood Impact"; "Residual Likelihood Impact")
                    {
                        Caption = 'Residual Impact Value';
                        Editable = false;
                    }
                    field("Residual Risk Impact"; "Residual Risk Impact")
                    {
                        Editable = false;
                    }
                    field("Residual Risk (L * I)"; "Residual Risk (L * I)")
                    {
                        Caption = 'Residual Risk Score';
                        Editable = false;
                    }
                    field("Residual RAG Status"; "Residual RAG Status")
                    {
                        Editable = false;
                    }
                }
                group("Others")
                {
                    ShowCaption = false;
                    Visible = ChampionEditable;
                    field("Risk Response"; "Risk Response")
                    {
                        Caption = 'Acceptance Decision';
                    }
                    field(Comment; Comment)
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
                    Enabled = "No." <> '';

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        PgDocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(PgDocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        PgDocumentAttachment.OpenForRecReference(RecRef);
                        if Status = Status::Released then
                            PgDocumentAttachment.Editable(false);
                        PgDocumentAttachment.RUNMODAL;
                    end;
                }
            }
            action("Send To Risk Manager")
            {
                Caption = 'Send To Risk Manager';
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;


                trigger OnAction()
                var
                    RiskLine: Record "Risk Line";
                begin
                    // TestField("Risk Description");
                    //  TestField("Risk Region");
                    RiskLine.RESET;
                    RiskLine.SETRANGE("Document No.", "No.");
                    RiskLine.SETFILTER(Type, '%1|%2|%3', RiskLine.Type::"KRI(s)", RiskLine.Type::Response, RiskLine.Type::"Risk Category");
                    // IF NOT RiskLine.FINDFIRST() THEN Error('Please specify the risk KRI(s)');
                    RegistrationMgt.FnReportRisk(Rec, "Auditor Email");
                    CurrPage.CLOSE;
                end;
            }
            action("Send To Auditor")
            {
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    RiskLine: Record "Risk Line";
                begin
                    RiskLine.RESET;
                    RiskLine.SETRANGE("Document No.", "No.");
                    RiskLine.SETFILTER(Type, '%1|%2|%3', RiskLine.Type::"KRI(s)", RiskLine.Type::Response, RiskLine.Type::"Risk Category");
                    // IF NOT RiskLine.FINDFIRST() THEN Error('Please specify the risk KRI(s)');
                    // AuditMgt.RiskRegistersSTRNMenu(Rec);
                    if Rec."Document Status" = Rec."Document Status"::"Risk Owner" then
                        Rec."Document Status" := Rec."Document Status"::"Risk Manager";
                    Rec.Modify();
                    CurrPage.CLOSE;
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
                    Modify(true);
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Status = Status::New) or (Status = Status::"Pending Approval");
                trigger OnAction()
                var
                //  Workflows: Codeunit "Registration Workflows";
                begin
                    //  Workflows.RiskHeaderWorkflows(Rec);
                end;

            }

            action(Submit)
            {
                Caption = 'Submit Register Risk';
                Image = Approve;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = ChampionEditable;

                trigger OnAction()
                begin
                    If Status = Status::New then 
                    Status := Status::Released;
                    Modify();
                    CurrPage.CLOSE;
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        CheckVisibility;
        SetControlAppearance();

        CALCFIELDS("Risk Description", "Root Cause Analysis", "Mitigation Suggestions", "Existing Risk Controls");
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
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        CheckVisibility;
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
        RiskME: Boolean;
        RiskResponse: Boolean;
        RiskValue: Boolean;
        RiskOpportunity: Boolean;
        [InDataSet]
        LinksVisible: Boolean;
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;

    local procedure CheckVisibility()
    begin
        HidePageLinks();

        case "Document Status" of
            "Document Status"::New:
                begin
                    SendToRegister := false;
                    SendToChampion := true;
                end;
            "Document Status"::Champion:
                begin
                    SendToRegister := true;
                    SendToChampion := false;
                end;
            "Document Status"::Closed:
                begin
                    SendToRegister := false;
                    SendToChampion := false;
                end;
        end;
    end;

    procedure SetControlAppearance()
    begin
        if ("Document Status" = "Document Status"::New) then
            NewVisible := true
        else
            NewVisible := false;

        if ("Document Status" = "Document Status"::Champion) or ("Document Status" = "Document Status"::"Risk Owner") then
            ChampionEditable := true
        else
            ChampionEditable := false;

    end;

    procedure ShowLinksPage()
    begin
        LinksVisible := true;
    end;

    procedure HidePageLinks()
    begin
        LinksVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        "Plan Type" := "Plan Type"::"Organizational Plan";
    end;
}

