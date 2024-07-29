page 54862 "HMS Laboratory Item Header"
{
    PageType = Document;
    SourceTable = "HMS-Laboratory Test Line";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Test Code"; Rec."Laboratory Test Code")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Test Name"; Rec."Laboratory Test Name")
                {
                    ApplicationArea = All;
                }
                field("Specimen Code"; Rec."Specimen Code")
                {
                    ApplicationArea = All;
                }
                field("Specimen Name"; Rec."Specimen Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Collection Date"; Rec."Collection Date")
                {
                    ApplicationArea = All;
                }
                field("Collection Time"; Rec."Collection Time")
                {
                    ApplicationArea = All;
                }
                field("Measuring Unit Code"; Rec."Measuring Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Measuring Unit Name"; Rec."Measuring Unit Name")
                {
                    ApplicationArea = All;
                }
            }
            part(Page; "HMS Laboratory Item Subform")
            {
                SubPageLink = "Laboratory No." = FIELD("Laboratory No."),
                              //"Laboratory Test Package Code" = FIELD(Field2),
                              "Laboratory Test Code" = FIELD("Laboratory Test Code"),
                              "Specimen Code" = FIELD("Specimen Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Post Item Usage")
            {
                Caption = '&Post Item Usage';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you wish to post the record?', FALSE) = FALSE THEN BEGIN EXIT END;
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    ItemJnlLine.RESET;
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", HMSSetup."Laboratory Item Journal Temp");
                    ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", HMSSetup."Laboratory Item Journal Batch");
                    IF ItemJnlLine.FIND('-') THEN ItemJnlLine.DELETEALL;
                    LineNo := 1000;
                    PharmLine.RESET;
                    PharmLine.SETRANGE(PharmLine."Laboratory No.", Rec."Laboratory No.");
                    //PharmLine.SETRANGE(PharmLine."Laboratory Test Package Code","Laboratory Test Package Code");
                    PharmLine.SETRANGE(PharmLine."Laboratory Test Code", Rec."Laboratory Test Code");
                    PharmLine.SETRANGE(PharmLine."Specimen Code", Rec."Specimen Code");
                    PharmLine.SETRANGE(PharmLine.Posted, FALSE);
                    IF PharmLine.FIND('-') THEN BEGIN
                                                    REPEAT
                                                        ItemJnlLine.INIT;
                                                        ItemJnlLine."Journal Template Name" := HMSSetup."Laboratory Item Journal Temp";
                                                        ItemJnlLine."Journal Batch Name" := HMSSetup."Laboratory Item Journal Batch";
                                                        ItemJnlLine."Line No." := LineNo;
                                                        ItemJnlLine."Posting Date" := TODAY;
                                                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";

                                                        ItemJnlLine."Document No." := PharmLine."Laboratory No." + ':' + PharmLine."Item No.";
                                                        ItemJnlLine."Item No." := PharmLine."Item No.";
                                                        ItemJnlLine.VALIDATE(ItemJnlLine."Item No.");
                                                        ItemJnlLine."Location Code" := HMSSetup."Laboratory Room";
                                                        ItemJnlLine.VALIDATE(ItemJnlLine."Location Code");
                                                        ItemJnlLine.Quantity := PharmLine."Item Quantity";
                                                        ItemJnlLine.VALIDATE(ItemJnlLine.Quantity);
                                                        ItemJnlLine."Unit of Measure Code" := PharmLine."Item Unit Of Measure";
                                                        ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code");
                                                        ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                                                        ItemJnlLine.INSERT();
                                                        PharmLine.Posted := TRUE;
                                                        PharmLine.MODIFY;
                                                        LineNo := LineNo + 1;
                                                    /*Update the treatment lines*/
                                                    UNTIL PharmLine.NEXT = 0;
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);


                    END;

                end;
            }
        }
    }

    var
        HMSSetup: Record "HMS-Setup";
        LineNo: Integer;
        PharmLine: Record "HMS-Laboratory Item Usage";
        ItemJnlLine: Record 83;
}

