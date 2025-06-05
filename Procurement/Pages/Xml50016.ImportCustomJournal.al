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
                }
                fieldelement(JournalBatchName; GenJournalLine."Journal Batch Name")
                {
                }

                fieldelement(LineNo; GenJournalLine."Line No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }

                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }

                fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
                {
                }
                fieldelement(BalAccType; GenJournalLine."Bal. Account Type")
                {
                }
                fieldelement(BalAccountNo; GenJournalLine."Bal. Account No.")
                {
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
