page 54238 "Asset Repair Card  Others"
{
    PageType = Card;
    SourceTable = "Asset Repair Header";
    SourceTableView = WHERE("Asset Type" = FILTER("Other Assets"),
                            Status = FILTER('<>Approved'));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = true;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Total Assets"; Rec."Total Assets")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Asset Repair Lines")
            {
                SubPageLink = "Request No." = FIELD("Request No."),
                              "Asset Type" = FIELD("Asset Type");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Approval Request")
            {
                Caption = 'Approval Request';
                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        // IF ApprovalsMgmt.CheckAssetRepairApprovalsWorkflowEnabled(Rec) THEN
                        //   ApprovalsMgmt.OnSendAssetRepairForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelAssetRepairApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        ApprovalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID)
                    end;
                }
                action("Confirmation Of Work Done")
                {
                    Image = AbsenceCategory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Confirmation of Work";
                    RunPageLink = "Gate Pass No." = FIELD("Request No.");
                    ApplicationArea = All;
                }
                action(Print)
                {
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.SETFILTER("Request No.", Rec."Request No.");
                        //REPORT.RUN(REPORT::"Asset Repair Header Report",TRUE,TRUE,Rec);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Asset Type" := Rec."Asset Type"::"Other Assets";
    end;

    var
        ApprovalsMgmt: Codeunit 1535;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
}

