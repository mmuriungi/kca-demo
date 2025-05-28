xmlport 50017 "Import Gen Journal 2"
{
    Caption = 'Import Gen Journal 2';

    Caption = 'Gen Journal Line Import';
    Direction = Import;
    Format = VariableText;


    schema
    {
        textelement(Root)
        {
            tableelement(GenJournalLine; "Gen Line Custom2")
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
}
