xmlport 50016 "Import Custom Journal"
{
    Caption = 'Import Custom Journal1';

    Direction = Import;
    Format = VariableText;


    schema
    {
        textelement(Root)
        {
            tableelement(GenJournalLine; "Gen Line Custom1")
            {
                //journalname
                fieldelement(JournalName; GenJournalLine."Journal Template Name")
                {
                    MinOccurs = Zero;
                }
                fieldelement(JournalBatchName; GenJournalLine."Journal Batch Name")
                {
                    MinOccurs = Zero;
                }

                fieldelement(LineNo; GenJournalLine."Line No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                    MinOccurs = Zero;
                }

                fieldelement(Description; GenJournalLine.Description)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                    MinOccurs = Zero;
                }

                fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(BalAccType; GenJournalLine."Bal. Account Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(BalAccountNo; GenJournalLine."Bal. Account No.")
                {
                    MinOccurs = Zero;
                }


            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var

        line: Record 81;
}
