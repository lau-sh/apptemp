""" Routes for sample app """
import flask

from apptemp import app


@app.route('/')
@app.route('/index')
def index():
    """ Sample index page """

    body = {'header': 'Test Header'}
    return flask.render_template('index.html',
                                 title='Test Page',
                                 body=body)
