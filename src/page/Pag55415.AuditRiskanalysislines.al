page 55415 "Audit - Risk analysis lines"
{
    CardPageID = "Audit-Risk analysis Header";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "AUDIT-Risk Analysis Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Departmant Name"; Rec."Departmant Name")
                {
                    ApplicationArea = All;
                }
                field(Likelihood; Rec.Likelihood)
                {
                    ApplicationArea = All;
                }
                field(Impact; Rec.Impact)
                {
                    ApplicationArea = All;
                }
                field("Overall Rating"; Rec."Overall Rating")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Responsible Persons"; Rec."Responsible Persons")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Group2)
            {
                action("Risk Summary Report")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    //RunObject = Report 99970;
                }
                action("Detailed Risk Report")
                {
                    Image = "Report";
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETFILTER(No, Rec.No);
                        IF Rec.FINDFIRST THEN
                            REPORT.RUN(99971, TRUE, FALSE, Rec);
                    end;
                }
            }
        }
        area(creation)
        {
            group(Group3)
            {
                action("Send To Audit")
                {
                    Image = SendTo;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                }
            }
        }
    }
}

