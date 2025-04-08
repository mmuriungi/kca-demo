page 50219 "Credit Management Setup"
{

    Caption = 'Credit Management Setup';
    PageType = Card;
    SourceTable = "Credit Management Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. of Days in Year"; "No. of Days in Year")
                {
                    ApplicationArea = All;
                }
                field("Loan Disbursement Template"; "Loan Disbursement Template")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Template"; "Loan Interest Template")
                {
                    ApplicationArea = All;
                }
                field("Loan Penalty Template"; "Loan Penalty Template")
                {
                    ApplicationArea = All;
                }
                field("Default PML Posting Group"; "Default PML Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Enforce Credit Limit"; "Enforce Credit Limit")
                {
                    ApplicationArea = All;
                }
                field("Max Phone No Characters"; "Max Phone No Characters")
                {
                    ApplicationArea = All;
                }
                field("Credit Limit Amount Type"; "Credit Limit Amount Type")
                {
                    ApplicationArea = All;
                }
                field("Check Collateral Commitment"; "Check Collateral Commitment")
                {
                    ApplicationArea = All;
                }
                field("Automatically Post Interest"; "Automatically Post Interest")
                {
                    ApplicationArea = All;
                }
                field("VAT Product Posting Group"; "VAT Product Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Receipt Amounts Exclusive VAT";"Receipt Amounts Exclusive VAT")
                {
                    ApplicationArea = All;
                }


            }
            group(Numbering)
            {
                field("Assumption Nos"; "Assumption Nos")
                {
                    ApplicationArea = All;
                }

                field("Application Nos"; "Application Nos")
                {
                    ApplicationArea = All;
                }
                field("PML Change Request Nos"; "PML Change Request Nos")
                {
                    ApplicationArea = All;
                }

                field("Loan Nos"; "Loan Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Disbursement Nos"; "Loan Disbursement Nos")
                {
                    ApplicationArea = All;
                }
                field("Credit Scoring Nos"; "Credit Scoring Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Nos"; "Loan Interest Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Penalty Nos"; "Loan Penalty Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Receipt Nos"; "Loan Receipt Nos")
                {
                    ApplicationArea = All;
                }
                field("Statement Template Nos"; "Statement Template Nos")
                {
                    ApplicationArea = All;
                }
                field("Shareholding Setup Nos"; "Shareholding Setup Nos")
                {
                    ApplicationArea = All;
                }
                field("Risk Profile Nos"; "Risk Profile Nos")
                {
                    ApplicationArea = All;
                }
                field("Residential Mortgage Nos"; "Residential Mortgage Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Collateral Nos"; Rec."Loan Collateral Nos")
                {
                    ApplicationArea = All;
                }
            }
            group(Signatories)
            {
                field("Signatory 1 No."; "Signatory 1 No.")
                {
                    ApplicationArea = All;

                }
                field("Signatory 1 Name"; "Signatory 1 Name")
                {
                    ApplicationArea = All;

                }
                field("Signatory 1 designation"; "Signatory 1 designation")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 No."; "Signatory 2 No.")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 Name"; "Signatory 2 Name")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 designation"; "Signatory 2 designation")
                {
                    ApplicationArea = All;

                }
            }
            group("Reports Text")
            {
                Caption = 'Reports Text';
                field("Statement Notes"; SNotesText)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;

                    trigger OnValidate()
                    begin

                        CalcFields("Statement Notes");
                        "Statement Notes".CreateInStream(Instr);
                        SNotes.Read(Instr);

                        if SNotesText <> Format(SNotes) then begin
                            Clear("Statement Notes");
                            Clear(SNotes);
                            SNotes.AddText(SNotesText);
                            "Statement Notes".CreateOutStream(OutStr);
                            SNotes.Write(OutStr);

                        end;
                    end;
                }
            }
            //     field("Contr Recon Notes"; CRNotesText)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         MultiLine = true;

            //         trigger OnValidate()
            //         begin
            //             CalcFields("Contr Recon Notes");
            //             "Contr Recon Notes".CreateInStream(Instr);
            //             CRNotes.Read(Instr);

            //             if CRNotesText <> Format(CRNotes) then begin
            //                 Clear("Contr Recon Notes");
            //                 Clear(CRNotes);
            //                 CRNotes.AddText(CRNotesText);
            //                 "Contr Recon Notes".CreateOutStream(OutStr);
            //                 CRNotes.Write(OutStr);
            //             end;
            //         end;
            //     }

            // }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        CalcFields("Statement Notes");
        "Statement Notes".CreateInStream(Instr);
        SNotes.Read(Instr);
        SNotesText := Format(SNotes);
    end;

    var
        SNotes: BigText;
        SNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;

}
