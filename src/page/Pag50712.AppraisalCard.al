/// <summary>
/// Page Appraisal Card (ID 50013).
/// </summary>
page 50712 "Appraisal Card"
{
    Caption = 'Appraisal Card';
    PageType = Card;
    PromotedActionCategories = 'New,Report,Process,Approvals,Training Needs,Reviews,Reports,Target Setting';
    SourceTable = Appraisal;

    layout
    {
        area(content)
        {
            group("Section 1: General Information")
            {
                field("Appraisal No"; Rec."Appraisal No")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }
                field(period; Rec.period)
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    Caption = 'Personal No';
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    Caption = 'Staff Name';
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }


                field(Designation; Rec.Designation)
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Grade field.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field("Terms of Service"; Rec."Terms of Service")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terms of Service field.';
                }
                field("Supervisor No"; Rec."Supervisor No")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor No field.';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                }
                field("Supervisor Designation"; Rec."Supervisor Designation")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Designation field.';
                }
                field("Head of Directorate"; Rec."Head of Department")
                {
                    editable = fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Head of Directorate field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
            part(Targets; "Targets/Krs")
            {
                ApplicationArea = all;
                SubPageLink = "Employee No" = field("Employee Code"), "Appraisal No" = field("Appraisal No"), Period = field(Period);
            }
            group("Section 2: Core Values")
            {
                part("Core Values"; "Employee Core Values")
                {
                    ApplicationArea = all;
                    SubPageLink = "Appraisal No" = field("Appraisal No"), Period = field(Period), "Employee No" = field("Employee Code");
                }
            }








        }
    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                ApplicationArea = all;
                image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    if Approval.IsAppraisalEnabled(Rec) = true then
                        Approval.OnSendAppraisalforApproval(Rec);

                end;
            }
            // action(Approvals)
            // {
            //     ApplicationArea = all;
            //     image = GetLines;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = page "Fin-Approval Entries";
            //     RunPageLink = "Document No." = field("Appraisal No");
            // }
            action("Cancel Approval")
            {
                ApplicationArea = all;
                image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin

                    Approval.OnCancelAppraisalforApproval(Rec);

                end;
            }
            action("Targets Setting")
            {
                ApplicationArea = all;
                Image = SetupLines;
                RunObject = page "Targets/Krs";
                RunPageLink = "Employee No" = field("Employee Code"), "Appraisal No" = field("Appraisal No");
            }
            action("Target Review")
            {
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = category6;
                RunObject = page "Targets Review";
                RunPageLink = "Appraisal No" = field("Appraisal No"), "Employee No" = field("Employee Code"), Period = field(Period);


            }
            action("Perfomance Review")
            {
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = category6;
                RunObject = page "Perfomace Review";
                RunPageLink = "Appraisal No" = field("Appraisal No"), Period = field(Period), "Employee No" = field("Employee Code");
            }
            action("Training Needs")
            {
                ApplicationArea = all;
                Image = NewOpportunity;
                Promoted = true;
                PromotedCategory = category5;
                RunObject = page "Staff training and development";

                RunPageLink = "Employee Code" = field("Employee Code");
            }
            action("Appraisal Report")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    Appraisal.Reset();
                    Appraisal.SetRange("Appraisal No", rec."Appraisal No");
                    if Appraisal.Find('-') then begin
                        report.Run(report::"Appraisal Report", true, true, Appraisal);
                    end;

                end;
            }




        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        if rec.Status <> rec.Status::Open then begin
            fieldeditable := false
        end else
            fieldeditable := true;

        if rec.Status <> rec.Status::Approved then begin
            Revieweditable := false;
        end else
            Revieweditable := true;
    end;

    trigger OnOpenPage()
    begin
        if rec.Status <> rec.Status::Open then begin
            fieldeditable := false
        end else
            fieldeditable := true;
        if rec.Status <> rec.Status::Approved then begin
            Revieweditable := false;
        end else
            Revieweditable := true;
    end;

    var
        Review: record "Perfomance Review";
        fieldeditable: Boolean;
        Revieweditable: boolean;
        Appraisal: record Appraisal;
        Approval: Codeunit "Appraisal Init";
        Appsetup: record "Appraisal Setups";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}
