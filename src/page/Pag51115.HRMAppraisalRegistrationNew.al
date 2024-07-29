page 51115 "HRM-Appraisal Registration New"
{
    AutoSplitKey = true;
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Appraisal Registration";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {

                    trigger OnValidate()
                    begin
                        // BKK
                        CReg.RESET;
                        CReg.SETRANGE(CReg."PF No.", Rec."PF No.");
                        CReg.SETRANGE(CReg."Appraisal Job Code", Rec."Appraisal Job Code");
                        CReg.SETRANGE(CReg."Appraisal Period Code", Rec."Appraisal Period Code");
                        CReg.SETRANGE(CReg."Appraisal Year Code", Rec."Appraisal Year Code");
                        IF CReg.FIND('-') THEN BEGIN
                            ERROR('Stage ' + CReg."Appraisal Period Code" + ' Already Exist For This Employee')
                        END;
                    end;
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {

                }
                field("Registration Date"; Rec."Registration Date")
                {

                    Editable = false;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                }
                field(Award; Rec.Award)
                {

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Registered Courses")
            {
                Caption = 'Print';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CReg.RESET;
                    CReg.SETFILTER(CReg."Appraisal Period Code", Rec."Appraisal Period Code");
                    CReg.SETFILTER(CReg."PF No.", Rec."PF No.");
                    CReg.SETFILTER(CReg."Reg. Transacton ID", Rec."Reg. Transacton ID");
                    IF CReg.FIND('-') THEN
                        REPORT.RUN(39005951, TRUE, TRUE, CReg);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ProgDesc := '';
    end;

    var
        Prog: Record "HRM-Appraisal Jobs";
        ProgDesc: Text[200];
        CReg: Record "HRM-Appraisal Registration";

    local procedure OnBeforePutRecord()
    begin
        ProgDesc := '';
    end;
}

