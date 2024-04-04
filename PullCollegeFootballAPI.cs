using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net.HTTP;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.JSON;

using MyNamespace;//Need to create a namespace to use so the models can be used in this
;

public class PullCollegeFootballAPI
{
    public PullCollegeFootballAPI()
    {
        static async Task main(string[] args)
        {
            //Data for any FBS team in college football.
            //This gives a teamID to use for others
            string teamData = await GetJsonData("https://api.collegefootballdata.com/teams/fbs");
            //Coaching data with previous teams as well.
            //Uses first and last name to search for previous teams and info, NOT CoachID
            string coachData = await GetJsonData("https://api.collegefootballdata.com/coaches");
            //Roster data for given teams and seasons.
            //Gives a season ID along with every player on the roster for that season
            //Will have to place certain information into correct tables.
            string rosterData = await GetJsonData("https://api.collegefootballdata.com/roster");
            //Data for all conferences, includes recent realignment of Pac12
            //ConferenceIDs
            string conferenceData = await GetJsonData("https://api.collegefootballdata.com/conferences");
            //Allows for specific players
            //Gives a playerID
            string playerData = await GetJsonData("https://api.collegefootballdata.com/players");//


            List<Team> fbsTeams = JsonConvert.DeserializeObject<List<Team>>(teamsData); //Need to create the models to use for this.
        }
    }
}