codeunit 50098 "Risk Ratings Colour Codes"
{
    procedure RiskRatingColours(RisckEVScore: Record "Risk Evaluation Score"): Text[50]
    begin
        case RisckEVScore."Risk Rating" of
            RisckEVScore."Risk Rating"::"VERY HIGH":
                exit('Attention');
            RisckEVScore."Risk Rating"::HIGH:
                exit('unfavorable');
            RisckEVScore."Risk Rating"::"VERY LOW":
                exit('Favorable');
            RisckEVScore."Risk Rating"::LOW:
                exit('ambiguous');
            RisckEVScore."Risk Rating"::MEDIUM:
                exit('ambiguous');

        end;
    end;

    // procedure RiskScoreColours(RiskScore: Record "Risk Scores Colours"): Text[90]
    // begin
    //     with RiskScore do
    //         case Score of
    //         if  Score=8 then
    //       exit('Attention');
    //         end;
    // end;


}
