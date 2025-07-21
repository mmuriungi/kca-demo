page 50220 "Risk Details"
{
    Caption = 'Risk Details';
    PageType = ListPart;
    SourceTable = "Risk Details";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Risk Details Line"; Rec."Risk Details Line")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Risk No';
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

                field("Risk Descriptions"; Rec."Risk Descriptions")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Description';
                    MultiLine = true;
                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                    ApplicationArea = All;
                    // StyleExpr = StyleExprTxt;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        //  StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
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
                    Visible = false;
                }
                field("Risk Impact Value"; Rec."Risk Impact Value")
                {
                    ApplicationArea = All;
                    Caption = 'Impact Score';
                    Editable = false;
                }

                field("Risk (L * I)"; Rec."Risk (L * I)")
                {
                    Caption = 'Gross Risk Score';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin

                    end;
                }

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


                field(Archive; Rec.Archive)
                {
                    ApplicationArea = All;

                }
                field("No of Records"; Rec."No of Records")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Function Code"; Rec."Funtion Code")
                {
                    ApplicationArea = All;
                }
                field("Function Description"; Rec."Function Description")
                {
                    ApplicationArea = All;

                }
                field("Objective Average"; Rec."Objective Average")
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
            action("Get Gross Risk Score")
            {
                ApplicationArea = All;
                Caption = 'Get Gross Risk Score';
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                //Visible = "Document Status" = "Document Status"::New;
                trigger OnAction()
                begin
                    ObjRiskDetails.Reset();
                    ObjRiskDetails.SetRange(ObjRiskDetails."Risk No.", Rec."Risk No.");
                    if ObjRiskDetails.FindSet() then begin
                        repeat
                            ObjRiskDetails.SetAutoCalcFields("Risk Impact Value");
                            ObjRiskDetails.SetAutoCalcFields("Risk Likelihood Value");
                            ObjRiskDetails.SetAutoCalcFields("No of Records");
                            ObjRiskDetails."Risk (L * I)" := (ObjRiskDetails."Risk Impact Value" * ObjRiskDetails."Risk Likelihood Value") * Rec."No of Records";
                            ObjRiskDetails."Risk Impact Value" := (Rec."Risk Impact Value" * Rec."No of Records");
                            ObjRiskDetails."Risk Likelihood Value" := (Rec."Risk Likelihood Value" * Rec."No of Records");
                            //Message('Risk Impact Value %1 Risk Likelihood Value %2', "Risk Impact Value", "Risk Likelihood Value");
                            ObjRiskDetails.Modify();
                            CurrPage.Update();
                        until ObjRiskDetails.Next = 0;
                    end;
                end;

            }
            action("Causes & Effects")
            {
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Causes & Effects";
                RunPageLink = "Risk Details Line" = field("Risk Details Line");
            }
            action("Risk Type")
            {
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Risk Type";
                RunPageLink = "Risk Details Line" = field("Risk Details Line");
            }
            action("Comments")
            {
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "Comment List";
                RunPageLink = "No." = field("Risk Details Line");
            }


        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Risk (L * I)" <= 8 then
            StyleExprTxt := 'Favorable'
        else
            if (Rec."Risk (L * I)" = 9) or (Rec."Risk (L * I)" <= 15) then
                StyleExprTxt := 'Ambiguous'
            else
                if (Rec."Risk (L * I)" = 16) or (Rec."Risk (L * I)" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';

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
