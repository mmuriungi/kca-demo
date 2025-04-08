page 50221 "Causes & Effects"
{
    ApplicationArea = All;
    Caption = 'Causes & Effects';
    PageType = List;
    SourceTable = "Causes & Effects2";
    UsageCategory = Lists;

    layout
    {

        area(content)
        {
            repeater(General)
            {

                field("Entry No"; Rec."Entry No")
                {
                    Editable = false;

                }
                field("Line Risk Category"; Rec."Line Risk Category")
                {
                    Editable = false;
                    Caption = 'Risk Category';
                }
                field(Causes; Rec.Causes)
                {
                    // MultiLine = true;
                }
                field(Effects; Rec.Effects)
                {
                    // MultiLine = true;
                }
                field("Opportunity (identify)"; Rec."Opportunity (identify)")
                {

                }

                field("Risk Rating Main"; Rec."Risk Rating Main")
                {
                    Caption = 'Risk Rating';
                    Visible = false;
                }
                field("Risk Impact Main"; Rec."Risk Impact Main")
                {
                    Caption = 'Risk Impact';
                }
                field("Risk Impact Value Main"; Rec."Risk Impact Value Main")
                {
                    Caption = 'Impact Score';
                    Editable = false;
                }
                field("Risk Likelihood Main"; Rec."Risk Likelihood Main")
                {
                    Caption = 'Risk Likelihood';
                }
                field("Risk Likelihood Value Main"; Rec."Risk Likelihood Value Main")
                {
                    Caption = 'Risk Likelihood Value';
                    Editable = false;
                }
                field("Risk (L * I) Main"; Rec."Risk (L * I) Main")
                {
                    Caption = 'Gross Risk Score';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Q1; Rec.Q1)
                {

                }
                field("Risk Likelihood"; Rec."Risk Likelihood")
                {
                    ApplicationArea = All;
                    // StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        //  StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
                    end;
                }
                field("Risk Likelihood Value"; Rec."Risk Likelihood Value")
                {
                    Caption = 'Likelihood Score';
                    Editable = false;
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
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
                    Caption = 'Impact Score';
                    Editable = false;
                    Visible = false;
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
                field(Q2; Rec.Q2)
                {

                }
                field("Risk Likelihood Q2"; Rec."Risk Likelihood Q2")
                {
                    ApplicationArea = All;
                    // StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        //  StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
                    end;
                }
                field("Risk Likelihood Value Q2"; Rec."Risk Likelihood Value Q2")
                {
                    Caption = 'Likelihood Score Q2';
                    Editable = false;
                }
                field("Risk Rating Q2"; Rec."Risk Rating Q2")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Risk Impact Q2"; Rec."Risk Impact Q2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Risk Impact Value Q2"; Rec."Risk Impact Value Q2")
                {
                    Caption = 'Impact Score Q2';
                    Editable = false;
                    Visible = false;
                }

                field("Risk (L * I) Q2"; Rec."Risk (L * I) Q2")
                {
                    Caption = 'Gross Risk Score Q2';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Q3; Rec.Q3)
                {

                }
                field("Risk Likelihood Q3"; Rec."Risk Likelihood Q3")
                {
                    ApplicationArea = All;
                    // StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        //  StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
                    end;
                }
                field("Risk Likelihood Value Q3"; Rec."Risk Likelihood Value Q3")
                {
                    Caption = 'Likelihood Score Q3';
                    Editable = false;
                }
                field("Risk Rating Q3"; Rec."Risk Rating Q3")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Risk Impact Q3"; Rec."Risk Impact Q3")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Risk Impact Value Q3"; Rec."Risk Impact Value Q3")
                {
                    Caption = 'Impact Score Q3';
                    Editable = false;
                    Visible = false;
                }

                field("Risk (L * I) Q3"; Rec."Risk (L * I) Q3")
                {
                    Caption = 'Gross Risk Score Q3';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Document Status"; Rec."Document Status")
                {
                    Editable = false;
                }

            }



        }


    }
    actions
    {
        area(Processing)
        {
            action(Treatments)
            {
                Image = Process;

                RunObject = page Treatment;
                RunPageLink = "Entry No" = field("Entry No");
                ApplicationArea = All;
                //Enabled = Enabled;
                trigger OnAction()
                begin
                    //   Message('Here is the Treament!');
                end;

            }

            action("Upload Documents")
            {
                ApplicationArea = all;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Enabled = "Entry No." <> '';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    PgDocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(PgDocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    PgDocumentAttachment.OpenForRecReference(RecRef);
                    //if Status = Status::Released then
                    PgDocumentAttachment.Editable(false);
                    PgDocumentAttachment.RUNMODAL;
                end;

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        //Main
        if Rec."Risk (L * I) Main" <= 4.4 then
            StyleExprTxt := 'Favorable'
        else
            if (Rec."Risk (L * I) Main" = 4.5) or (Rec."Risk (L * I) Main" <= 14.4) then
                StyleExprTxt := 'Ambiguous'
            else
                if (Rec."Risk (L * I) Main" = 14.5) or (Rec."Risk (L * I) Main" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';

        //Q1

        if Rec."Risk (L * I)" <= 4.4 then
            StyleExprTxt := 'Favorable'
        else
            if (Rec."Risk (L * I)" = 4.5) or (Rec."Risk (L * I)" <= 14.4) then
                StyleExprTxt := 'Ambiguous'
            else
                if (Rec."Risk (L * I)" = 14.5) or (Rec."Risk (L * I)" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';

        //Q2

        if Rec."Risk (L * I) Q2" <= 4.4 then
            StyleExprTxt := 'Favorable'
        else
            if (Rec."Risk (L * I) Q2" = 4.5) or (Rec."Risk (L * I) Q2" <= 14.4) then
                StyleExprTxt := 'Ambiguous'
            else
                if (Rec."Risk (L * I) Q2" = 14.5) or (Rec."Risk (L * I) Q2" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';

        //Q3

        if Rec."Risk (L * I) Q3" <= 4.4 then
            StyleExprTxt := 'Favorable'
        else
            if (Rec."Risk (L * I) Q3" = 4.5) or (Rec."Risk (L * I) Q3" <= 14.4) then
                StyleExprTxt := 'Ambiguous'
            else
                if (Rec."Risk (L * I) Q3" = 14.5) or (Rec."Risk (L * I) Q3" <= 25) then
                    StyleExprTxt := 'unfavorable'
                else
                    StyleExprTxt := '';
    end;

    trigger OnOpenPage()
    begin
        // StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(ObjRiskEv);
        if (Rec."Document Status" = Rec."Document Status"::"Risk Manager") or (Rec."Document Status" = Rec."Document Status"::"Risk Owner") then
            Enabled := true
        else
            Enabled := false;
    end;

    procedure FnDocumentStage()
    begin
        if (Rec."Document Status" = Rec."Document Status"::"Risk Manager") or (Rec."Document Status" = Rec."Document Status"::"Risk Owner") then
            Enabled := true
        else
            Enabled := false;
    end;

    var
        Enabled: Boolean;
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
    // RiskRatingColourCodes: Codeunit "Risk Ratings Colour Codes";


}
