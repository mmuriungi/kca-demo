page 50098 "Consolidated Risk Card"
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
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                }
                field("Current Plan"; Rec."Current Plan")
                {
                    ShowMandatory = true;
                }

                field(Auditor; Rec.Auditor)
                {
                    ApplicationArea = All;
                    Caption = 'Risk Manager No';
                    Visible = false;
                }
                field("Auditor Name"; Rec."Auditor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Manager Name';
                    Visible = false;
                }
                field("Auditor Emai"; Rec."Auditor Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk Manager Email';
                    Visible = false;
                }

                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    Editable = Rec."Document Status" = Rec."Document Status"::Champion;
                    Visible = false;
                }
                field("Risk Description"; Rec."Risk Description")
                {
                    Caption = 'Comments';
                    Editable = true;
                }
            }

            part("Risk Details"; "Risk Details")
            {
                SubPageLink = "Risk No." = field("No.");
            }

            field("Root Cause Analysis"; Rec."Root Cause Analysis")
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                Visible = false;
            }
            field("Mitigation Suggestions"; Rec."Mitigation Suggestions")
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                Visible = false;
                trigger OnValidate()
                begin
                    
                end;
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
                    field("Existing Risk Controls"; Rec."Existing Risk Controls")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        trigger OnValidate()
                        begin
                           
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
                    RiskLine.SETRANGE("Document No.", Rec."No.");
                    RiskLine.SETFILTER(Type, '%1|%2|%3', RiskLine.Type::"KRI(s)", RiskLine.Type::Response, RiskLine.Type::"Risk Category");
                    // IF NOT RiskLine.FINDFIRST() THEN Error('Please specify the risk KRI(s)');
                    RegistrationMgt.FnReportRisk(Rec, Rec."Auditor Email");
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
                    RiskLine.SETRANGE("Document No.", Rec."No.");
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
                    Rec.Modify(true);
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (Rec.Status = Rec.Status::New) or (Rec.Status = Rec.Status::"Pending Approval");
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
                    If Rec.Status = Rec.Status::New then
                        Rec.Status := Rec.Status::Released;
                    Rec.Modify();
                    CurrPage.CLOSE;
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        CheckVisibility;
        SetControlAppearance();       
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
        Rec."Plan Type" := Rec."Plan Type"::"Organizational Plan";
    end;
}

