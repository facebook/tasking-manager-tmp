from flask_restful import Resource, request, current_app
from schematics.exceptions import DataError
from datetime import date, timedelta

from backend.models.dtos.team_dto import TeamMembersStatsQuery
from backend.services.team_service import TeamService
from backend.services.users.authentication_service import token_auth
from backend.api.utils import validate_date_input


class TeamMemberStatisticsAPI(Resource):
    @token_auth.login_required
    def get(self, team_id):
        """
        Get stats about each member of a team
        ---
        tags:
          - teams
        produces:
          - application/json
        parameters:
            - in: header
              name: Authorization
              description: Base64 encoded session token
              required: true
              type: string
              default: Token sessionTokenHere==
            - name: teamID
              in: path
              description: Team id
              required: true
              type: string
              default: 1
            - in: query
              name: page
              description: Page of results user requested
              type: integer
            - in: query
              name: startDate
              description: Initial date
              required: true
              type: string
            - in: query
              name: endDate
              description: Final date.
              type: string
            - in: query
              name: projectID
              description: Optional project_id
              type: integer
        responses:
            200:
                description: User found
            401:
                description: Unauthorized - Invalid credentials
            404:
                description: User not found
            500:
                description: Internal Server Error
        """
        try:
            query = TeamMembersStatsQuery()
            query.team_id = team_id
            query.page = (
                int(request.args.get("page")) if request.args.get("page") else 1
            )
            start_date = validate_date_input(request.args.get("startDate"))
            end_date = validate_date_input(request.args.get("endDate", date.today()))
            if not (start_date):
                raise KeyError("MissingDate- Missing start date parameter")
            if end_date < start_date:
                raise ValueError(
                    "InvalidStartDate- Start date must be earlier than end date"
                )
            if (end_date - start_date) > timedelta(days=366):
                raise ValueError(
                    "InvalidDateRange- Date range can not be bigger than 1 year"
                )
            query.start_date = start_date
            query.end_date = end_date
            query.project_id = request.args.get("projectID")
            query.validate()
        except DataError as e:
            current_app.logger.error(f"error validating request: {str(e)}")
            return {"Error": str(e), "SubCode": "InvalidData"}, 400

        try:
            stats_dto = TeamService.get_team_members_stats(query)
            return stats_dto.to_primitive(), 200
        # except NotFound:
        #     return {"Error": "User not found", "SubCode": "NotFound"}, 404
        except Exception as e:
            error_msg = f"User GET - unhandled error: {str(e)}"
            current_app.logger.critical(error_msg)
            return {
                "Error": "Unable to fetch team members statistics",
                "SubCode": "InternalServerError",
            }, 500
