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
                field("Audit Plan No."; "Audit Plan No.")
                {
                    Editable = false;
                }
                field("Risk No"; "Risk No")
                {

                }
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
                field("Risk Descriptions"; "Risk Descriptions")
                {
                    Caption = 'Risk Description';
                    MultiLine = true;
                }
                field("Risk Likelihood"; "Risk Likelihood")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
                    end;
                }
                field("Risk Likelihood Value"; "Risk Likelihood Value")
                {
                    Caption = 'Likelihood Score';
                    Editable = false;
                }
                field("Risk Rating"; "Risk Rating")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Risk Impact"; "Risk Impact")
                {
                    ApplicationArea = All;
                }
                field("Risk Impact Value"; "Risk Impact Value")
                {
                    Caption = 'Impact Score';
                    Editable = false;
                }

                field("Risk (L * I)"; "Risk (L * I)")
                {
                    Caption = 'Gross Risk Score';
                    Editable = false;
                }
                field("Root Cause Analysis2"; "Root Cause Analysis2")
                {
                    ApplicationArea = all;
                    // Editable = false;
                    MultiLine = true;
                    Caption = 'Root Cause Analysis';
                }
                field("Mitigation Suggestions2"; "Mitigation Suggestions2")
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
                field(Department; Department)
                {
                    // Editable = false;
                    Visible = false;
                }
                field("To Consolidate"; "To Consolidate")
                {
                    //Editable = "Document Status" = "Document Status"::Auditor;
                }
                // field("Document Status"; "Document Status")
                // {
                //     Editable = false;
                // }

                field(Archive; Archive)
                {

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

