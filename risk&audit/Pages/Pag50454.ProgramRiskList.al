page 50101 "Program Risk List"
{
    Caption = 'Risk Details';
    PageType = ListPart;
    SourceTable = "Program Risks Lines";
    //
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit Plan No."; Rec."Audit Plan No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Risk No"; Rec."Risk No")
                {
                    ApplicationArea = All;

                }
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
                field("Risk Descriptions"; Rec."Risk Descriptions")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Description';
                    MultiLine = true;
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
                    end;
                }
                field("Risk Likelihood Value"; Rec."Risk Likelihood Value")
                {
                    ApplicationArea = All;
                    Caption = 'Likelihood Score';
                    Editable = false;
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Risk Impact"; Rec."Risk Impact")
                {
                    ApplicationArea = All;
                }
                field("Risk Impact Value"; Rec."Risk Impact Value")
                {
                    ApplicationArea = All;
                    Caption = 'Impact Score';
                    Editable = false;
                }

                field("Risk (L * I)"; Rec."Risk (L * I)")
                {
                    ApplicationArea = All;
                    Caption = 'Gross Risk Score';
                    Editable = false;
                }
                field("Root Cause Analysis2"; Rec."Root Cause Analysis2")
                {
                    ApplicationArea = all;
                    // Editable = false;
                    MultiLine = true;
                    Caption = 'Root Cause Analysis';
                }
                field("Mitigation Suggestions2"; Rec."Mitigation Suggestions2")
                {
                    ApplicationArea = all;
                    // Editable = false;
                    MultiLine = true;
                    Caption = 'Mitigation Suggestions';
                }
                // field("Risk No."; "Risk No.")
                // {
                //     Editable = false;
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Visible = false;
                }
                field("To Consolidate"; Rec."To Consolidate")
                {
                    ApplicationArea = All;
                    //Editable = "Document Status" = "Document Status"::Auditor;
                }
                // field("Document Status"; "Document Status")
                // {
                //     Editable = false;
                // }

                field(Archive; Rec.Archive)
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
            // action("Get Gross Risk Score")
            // {
            // Visible = false;
            // Caption = 'Get Gross Risk Score';
            // Image = Process;
            // Promoted = true;
            // PromotedCategory = Category4;
            // PromotedIsBig = true;
            // //Visible = "Document Status" = "Document Status"::New;
            // trigger OnAction()
            // begin
            //     ObjRiskDetails.Reset();
            //     ObjRiskDetails.SetRange(ObjRiskDetails."Risk No.", "Risk No.");
            //     if ObjRiskDetails.FindSet() then begin
            //         repeat

            //             ObjRiskDetails."Risk (L * I)" := (ObjRiskDetails."Risk Impact Value" * ObjRiskDetails."Risk Likelihood Value");
            //             ObjRiskDetails.Modify();
            //             CurrPage.Update();
            //         until ObjRiskDetails.Next = 0;
            //     end;
            // end;

            // }
        }
    }
    trigger OnAfterGetRecord()
    begin

        // CALCFIELDS("Risk Description", "Root Cause Analysis", "Mitigation Suggestions", "Existing Risk Controls");
        // "Risk Description".CREATEINSTREAM(Instr);
        // RiskNote.READ(Instr);
        // RiskNotesText := FORMAT(RiskNote);

        // "Root Cause Analysis".CREATEINSTREAM(Instr);
        // RootCauseBigTxt.READ(Instr);
        // RootCauseTxt := FORMAT(RootCauseBigTxt);

        // "Mitigation Suggestions".CREATEINSTREAM(Instr);
        // MitigationBigTxt.READ(Instr);
        // MitigationTxt := FORMAT(MitigationBigTxt);

        // "Existing Risk Controls".CREATEINSTREAM(Instr);
        // ExistingBigTxt.READ(Instr);
        // ExistingTxt := FORMAT(ExistingBigTxt);

        // ObjRiskEv.Reset();
        // ObjRiskEv.SetRange(ObjRiskEv.Description, "Risk Likelihood");
        // if ObjRiskEv.FindFirst() then begin
        //     StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
        //     // Message(' Test %1', StyleExprTxt);
        // end;

    end;

    trigger OnOpenPage()
    begin
        StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
    end;

    var
        RootCauseBigTxt: BigText;
        RootCauseTxt: Text;
        MitigationBigTxt: BigText;
        MitigationTxt: Text;
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        ExistingBigTxt: BigText;
        ExistingTxt: Text;
        ObjRiskDetails: Record "Risk Details";
        ActionLikelihood: Text;
        ActionStyle: Text;
        ObjRiskEv: Record "Risk Evaluation Score";
        StyleExprTxt: Text;
        RiskRatingColourCodes: Codeunit "Risk Ratings Colour Codes";



}

