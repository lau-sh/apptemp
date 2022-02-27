""" Flask app initializer """
import flask

app = flask.Flask(__name__, template_folder='../templates')

# pylint: disable=cyclic-import,wrong-import-position,unused-import
import apptemp.routes  # noqa: E402,F401
