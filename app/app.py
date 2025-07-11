import os
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'user'
    id   = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ['DATABASE_URL']
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

    with app.app_context():
        db.create_all()

    @app.route('/', methods=['GET', 'POST'])
    def index():
        if request.method == 'POST':
            name = request.form.get('name')
            if name:
                db.session.add(User(name=name))
                db.session.commit()
            return redirect(url_for('index'))

        users = User.query.all()
        return render_template('index.html', users=users)

    return app

if __name__ == '__main__':
    create_app().run(host='0.0.0.0', port=5000)