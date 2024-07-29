page 54855 "HMS-Labaratory Test Line"
{
    PageType = ListPart;
    SourceTable = "HMS-Laboratory Test Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Specimen Code"; Rec."Specimen Code")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Laboratory Test Code"; Rec."Laboratory Test Code")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Laboratory Test Name"; Rec."Laboratory Test Name")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Specimen Name"; Rec."Specimen Name")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Collection Time"; Rec."Collection Time")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Measuring Unit Code"; Rec."Measuring Unit Code")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Measuring Unit Name"; Rec."Measuring Unit Name")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Count Value"; Rec."Count Value")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
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
            action("Results Parameters")
            {
                Caption = 'Results Parameters';

                RunObject = Page "HMS Lab Test Results Parameter";
                RunPageLink = "Laboratory Test Code" = FIELD("Laboratory Test Code"),
                              "Laboratory No." = FIELD("Laboratory No.");
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                   Receip.RESET;
                   Receip.SETRANGE(Receip."Receipt No.","Receipt No.");
                   IF Receip.FIND('-') THEN
                   REPORT.RUN(39005962,TRUE,FALSE,Receip);
                   //REPORT.RUN(39005902,TRUE,FALSE,Receip);
                    */

                end;
            }
        }
    }
}

