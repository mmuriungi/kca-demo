page 50548 "HRM-Appraisal Registration"
{
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
                    Editable = true;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Caption = 'Appraisal Period';
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Editable = true;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Caption = 'Reg. Date';
                    Editable = true;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Editable = true;
                }
                field("Appraisal Jobs Category"; Rec."Appraisal Jobs Category")
                {
                    Editable = true;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Trimester Activities")
            {
                Caption = 'Trimester Activities';
                Description = 'Activities in a Trimester';
                Image = LotInfo;
                action(AppraisalTargets)
                {
                    Caption = 'Appraisal Targers';
                    Image = BOMRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Appraisee Target";
                    /*   RunPageLink = "PF. No."=FIELD("PF No."),
                                    "Appraisal Period Code"=FIELD("Appraisal Period Code"),
                                    "Appraisal Job Code"=FIELD("Appraisal Job Code"); */
                }
            }
        }
    }

    var
        Cust: Record Customer;
}

