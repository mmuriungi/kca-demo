page 50018 "FIN-Payment Lines"
{
    PageType = ListPart;
    SourceTable = "FIN-Payment Line";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        // If Rec."Account Type" <> Rec."Account Type"::"G/L Account" then
                        //     VoteheadVisible := True
                        // else
                        //     VoteheadVisible := false;
                        Rec.Validate("Account Type");

                    end;
                }
                field("Document No"; Rec."Document No")
                {
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        If Rec."Account Type" = Rec."Account Type"::"G/L Account" then
                            VoteheadVisible := false
                        else
                            VoteheadVisible := True;

                    end;

                }
                field(Grouping; Rec.Grouping)
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
                            Rec."Vote Head" := Rec."Account No.";


                    end;
                    //Caption='Vote Head';
                }
                field("Vote Head"; Rec."Vote Head")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Visible = VoteheadVisible;
                    // Visible=false;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = all;

                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = all;

                }
                field("Budget Balance"; Rec."Budget Balance")
                {
                    ApplicationArea = all;
                }
                field("Document Line"; Rec."Document Line")
                {
                    Visible = false;
                }


                field("Council No."; Rec."Council No.")
                {
                    //ApplicationArea = All;
                    Visible = false;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                }
                field("Not Vatable"; Rec."Not Vatable")
                {
                    ApplicationArea = All;
                }

                field("Manual Tax"; Rec."Manual Tax")
                {
                    ApplicationArea = All;
                }
                field("VAT Withheld Amount"; Rec."VAT Withheld Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Manual Tax" = true then begin
                            if Rec."VAT Withheld Amount" > 0 then
                                Rec."Net Amount" := Rec.Amount - Rec."VAT Withheld Amount" - Rec."Withholding Tax Amount";

                        end;
                    end;
                }
                field("VAT Withheld Code"; Rec."VAT Withheld Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Six % Rate"; Rec."VAT Six % Rate")
                {
                    ApplicationArea = All;
                }
                field(Commission; Rec.Commission)
                {
                    //ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        IF Rec."Payment Reference" = Rec."Payment Reference"::"Farmer Purchase" THEN BEGIN
                            IF Rec.Amount <> xRec.Amount THEN BEGIN
                                ERROR('Amount cannot be modified');
                            END;
                        END;

                        Rec."Amount With VAT" := Rec.Amount;
                        /*IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,
                        "Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"] THEN
                        
                        CASE "Account Type" OF
                          "Account Type"::"G/L Account":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN
                          BEGIN
                            RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                            TarriffCodes.RESET;
                            TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                            IF TarriffCodes.FIND('-') THEN
                              BEGIN
                                "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                              END;
                          END
                        ELSE
                          BEGIN
                            "VAT Amount":=0;
                          END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN
                          BEGIN
                            RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                            TarriffCodes.RESET;
                            TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                            IF TarriffCodes.FIND('-') THEN
                              BEGIN
                                "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "Withholding Tax Amount":=(Amount-"VAT Amount")*(TarriffCodes.Percentage/100);
                              END;
                          END
                        ELSE
                          BEGIN
                            "Withholding Tax Amount":=0;
                          END;
                        END;
                        END;
                          "Account Type"::Customer:
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        TESTFIELD("VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        TESTFIELD("Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                        
                            END;
                          "Account Type"::Vendor:
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        TESTFIELD("VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        TESTFIELD("Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                          "Account Type"::"Bank Account":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                          "Account Type"::"Fixed Asset":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                        END;
                        
                        
                        "Net Amount":=Amount-"Withholding Tax Amount";
                        VALIDATE("Net Amount");
                        */

                    end;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                    Visible = true;
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                    ApplicationArea = All;
                }

                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Manual Tax" = true then begin
                            if Rec."VAT Withheld Amount" > 0 then
                                Rec."Net Amount" := Rec.Amount - Rec."VAT Withheld Amount" - Rec."Withholding Tax Amount";

                        end;
                    end;
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    //ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field(Committed; Rec.Committed)
                {
                    ApplicationArea = All;
                }
                field("Budgetary Control A/C"; Rec."Budgetary Control A/C")
                {
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Rate"; Rec."VAT Rate")
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    ApplicationArea = All;
                }
                field("Retention  Amount"; Rec."Retention  Amount")
                {
                    ApplicationArea = All;
                }
                field("Commision Amount"; Rec."Commision Amount")
                {
                    ApplicationArea = All;
                }
                field("WHT 2 Code"; Rec."WHT 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT 2 Code field.', Comment = '%';
                }
                field("WHT 2 Amount"; Rec."WHT 2 Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT 2 Amount field.', Comment = '%';
                }
                field("levy Code"; Rec."levy Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the levy Code field.', Comment = '%';
                }
                field("Levy Rate"; Rec."Levy Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Levy Rate field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }

    var
        VoteheadVisible: Boolean;
    // RecPayTypes: Record "61129";
    // TarriffCodes: Record "61716";
    // GenJnlLine: Record "81";
    // DefaultBatch: Record "232";
    // CashierLinks: Record "61720";
    // LineNo: Integer;
    // CustLedger: Record "25";
    // CustLedger1: Record "25";
    // Amt: Decimal;
    // TotAmt: Decimal;
    // ApplyInvoice: Codeunit "402";
    // AppliedEntries: Record "61728";
    // VendEntries: Record "25";
    // PInv: Record "122";
    // VATPaid: Decimal;
    // VATToPay: Decimal;
    // PInvLine: Record "123";
    // VATBase: Decimal;
    // ImprestHeader: Record "61688";

    //[Scope('Internal')]
    procedure GetDocNo(): Code[20]
    begin
        //EXIT("Inv Doc No");
    end;
}